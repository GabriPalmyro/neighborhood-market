import 'dart:typed_data';

import 'package:neighborhood_market/app/features/create_product/data/model/edit_product_model.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/user_search_entity.dart';

abstract class CreateProductRepository {
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
  });

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
  });

  Future<EditProductModel> getProduct(String id);

  Future<List<UserSearchEntity>> searchUsers(String name, int page);

  void updateProductList();

  Future<List<CategoryEntity>> getCategories();
}
