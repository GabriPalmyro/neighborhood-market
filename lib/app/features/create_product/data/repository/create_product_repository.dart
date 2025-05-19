import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/create_product/data/model/category_model.dart';
import 'package:neighborhood_market/app/features/create_product/data/model/edit_product_model.dart';
import 'package:neighborhood_market/app/features/create_product/data/model/user_search_model.dart';
import 'package:neighborhood_market/app/features/create_product/domain/boundary/category_data_source.dart';
import 'package:neighborhood_market/app/features/create_product/domain/boundary/create_product_repository.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/user_search_entity.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart';

@Injectable(as: CreateProductRepository)
class CreateProductRepositoryImpl implements CreateProductRepository {
  CreateProductRepositoryImpl({
    required this.provider,
    required this.eventBus,
    required this.dataSource,
  });

  final NetworkProvider provider;
  final ReactiveListener eventBus;
  final CategoryDataSource dataSource;

  @override
  Future<void> createProduct({
    String? title,
    String? description,
    double? price,
    String? tag,
    CategoryEntity? category,
    String? brand,
    List<Uint8List>? images,
    bool? isTailored,
    String? details,
    String? flaws,
    String? gender,
    String? size,
    String? sellerId,
  }) async {
    final network = await provider.getNetworkInstance();

    // Crie o FormData
    final formData = FormData();
    // Adicione os campos simples
    formData.fields
      ..add(MapEntry('price', price?.toString() ?? ''))
      ..add(MapEntry('name', title ?? ''))
      ..add(MapEntry('description', description ?? ''))
      ..add(MapEntry('tags', tag ?? ''))
      ..add(MapEntry('brand', brand ?? ''))
      ..add(MapEntry('tailored', isTailored.toString()))
      ..add(MapEntry('acceptOffer', true.toString()))
      ..add(MapEntry('size', size ?? ''))
      ..add(MapEntry('gender', gender ?? ''))
      ..add(MapEntry('category', category?.id ?? ''))
      ..add(MapEntry('categoryType', category?.type?.name ?? ''));

    if (isTailored == true && details != null) {
      formData.fields.add(MapEntry('tailoredDetails', details));
    }

    if (flaws != null) {
      formData.fields.add(MapEntry('flaws', flaws));
    }

    // Adicione as imagens ao FormData
    if (images != null && images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        formData.files.add(
          MapEntry(
            'images',
            MultipartFile.fromBytes(
              images[i],
              filename: 'product_${DateTime.now().millisecondsSinceEpoch}_$i.jpg',
            ),
          ),
        );
      }
    }

    if (sellerId != null) {
      formData.fields.add(MapEntry('sellerId', sellerId));
      // Envie a solicitação registrando o produto como white-glove para o vendedor
      await network.post(
        '/item/white-glove',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
    } else {
      // Envie a solicitação de forma normal
      await network.post(
        '/item',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
    }
  }

  @override
  Future<EditProductModel> getProduct(String id) async {
    final network = await provider.getNetworkInstance();

    final response = await network.get('/item/$id');

    return EditProductModel.fromJson(response.data['item']);
  }

  @override
  Future<void> updateProduct({
    required String id,
    String? title,
    String? description,
    double? price,
    String? tag,
    // String? category,
    String? brand,
    List<Uint8List>? images,
    bool? isTailored,
    String? details,
    String? flaws,
    String? gender,
    String? size,
  }) async {
    final network = await provider.getNetworkInstance();

    // Crie o FormData
    final formData = FormData();

    // Adicione os campos simples
    formData.fields
      ..add(MapEntry('id', id))
      ..add(MapEntry('price', price?.toString() ?? ''))
      ..add(MapEntry('name', title ?? ''))
      ..add(MapEntry('description', description ?? ''))
      ..add(MapEntry('tags', tag ?? ''))
      ..add(MapEntry('brand', brand ?? ''))
      ..add(MapEntry('tailored', isTailored.toString()))
      ..add(MapEntry('acceptOffer', true.toString()))
      ..add(MapEntry('size', size ?? ''))
      ..add(MapEntry('gender', gender ?? ''));

    if (isTailored == true && details != null) {
      formData.fields.add(MapEntry('tailoredDetails', details));
    }

    if (flaws != null) {
      formData.fields.add(MapEntry('flaws', flaws));
    }

    // Adicione as imagens ao FormData
    if (images != null && images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        formData.files.add(
          MapEntry(
            'images',
            MultipartFile.fromBytes(
              images[i],
              filename: 'product_${DateTime.now().millisecondsSinceEpoch}_$i.jpg',
            ),
          ),
        );
      }
    }

    // Envie a solicitação
    await network.put(
      '/item',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  @override
  void updateProductList() {
    eventBus.publish(const FiltersSelected());
  }

  @override
  Future<List<UserSearchEntity>> searchUsers(String name, int page) async {
    final network = await provider.getNetworkInstance();

    final response = await network.get(
      '/user/list/all',
      queryParameters: {
        'name': name,
        'page': page,
      },
    );

    final data = response.data as Map<String, dynamic>;

    final users = data['response']['users'] as List;

    return users
        .map(
          (user) => UserSearchModel.fromJson(user).toEntity(),
        )
        .toList();
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final network = await provider.getNetworkInstance();

    try {
      final response = await network.get('/category');

      final categories = (response.data as List)
          .map(
            (category) => CategoryModel.fromJson(category).toEntity(),
          )
          .toList();

      try {
        dataSource.setCategories(categories);
      } catch (_) {}

      return categories;
    } catch (e) {
      try {
        final categories = await dataSource.getCategories();
        return categories;
      } catch (_) {
        return [];
      }
    }
  }
}
