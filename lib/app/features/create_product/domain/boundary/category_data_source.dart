import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';

abstract class CategoryDataSource {
  Future<List<CategoryEntity>> getCategories();
  Future<void> setCategories(List<CategoryEntity> category);
}
