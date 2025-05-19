import 'package:equatable/equatable.dart';

enum CategoryType {
  clothing('clothing'),
  shoes('Shoe'),
  accessories('accessory');

  const CategoryType(this.name);
  final String name;

  static CategoryType? fromString(String? type) {
    switch (type?.toLowerCase()) {
      case 'clothing':
        return CategoryType.clothing;
      case 'shoes':
        return CategoryType.shoes;
      case 'shoe':
        return CategoryType.shoes;
      case 'accessories':
        return CategoryType.accessories;
      case 'accessory':
        return CategoryType.accessories;
      default:
        return null;
    }
  }
}

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
    this.type,
    this.subcategories = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type?.name,
      'subcategories': subcategories?.map((x) => x.toMap()).toList(),
    };
  }

  final String id;
  final String name;
  final CategoryType? type;
  final List<CategoryEntity>? subcategories;

  CategoryEntity copyWith({
    String? id,
    String? name,
    CategoryType? type,
    List<CategoryEntity>? subcategories,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      subcategories: subcategories ?? this.subcategories,
    );
  }

  @override
  List<Object?> get props => [id, name, type, subcategories];
}
