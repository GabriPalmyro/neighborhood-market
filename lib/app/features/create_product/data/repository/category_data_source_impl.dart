import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/local_database/local_database.dart';
import 'package:neighborhood_market/app/features/create_product/data/model/category_model.dart';
import 'package:neighborhood_market/app/features/create_product/domain/boundary/category_data_source.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';
import 'package:neighborhood_market/app/features/create_product/utils/create_product_strings.dart';

@Injectable(as: CategoryDataSource)
class CategoryDataSourceImpl implements CategoryDataSource {
  CategoryDataSourceImpl({required LocalStorage localStorage}) : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      final categories = await _localStorage.getData<String>(CreateProductStrings.categoriesKey);

      final categoriesDecoded = jsonDecode(categories);

      final categoriesList = (categoriesDecoded as List<dynamic>)
          .map<CategoryEntity>(
            (category) => CategoryModel.fromJson(
              category,
            ).toEntity(),
          )
          .toList();

      return categoriesList;
    } catch (_) {}

    return [];
  }

  @override
  Future<void> setCategories(List<CategoryEntity> category) async {
    try {
      final categories = category.map((e) => e.toMap()).toList();

      await _localStorage.saveData(
        CreateProductStrings.categoriesKey,
        jsonEncode(categories),
      );
    } catch (_) {}
  }
}
