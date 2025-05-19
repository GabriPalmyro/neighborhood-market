import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    required this.name,
    this.type,
     this.subcategories = const [],
  });
  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: CategoryType.fromString(json['categoryType']),
      subcategories: json['subcategories'] != null
          ? List<CategoryModel>.from(json['subcategories'].map((x) => CategoryModel.fromJson(x)))
          : [],
    );
  }

  factory CategoryModel.fromItemJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['category'],
      name: json['categoryName'],
      type: CategoryType.fromString(json['categoryType']),
      subcategories: json['subcategories'] != null
          ? List<CategoryModel>.from(json['subcategories'].map((x) => CategoryModel.fromJson(x)))
          : [],
    );
  }

  final String id;
  final String name;
  final CategoryType? type;
  final List<CategoryModel>? subcategories;

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      type: type,
      subcategories: subcategories?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, type, subcategories];
}
