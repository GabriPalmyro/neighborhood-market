import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/common/extensions/string_extension.dart';

class FilterEntity extends Equatable {
  const FilterEntity({
    this.search,
    this.conditions = const [],
    this.sortBy,
    this.category,
    this.gender,
    this.clothingSize,
    this.shoeSize,
    this.minPrice,
    this.maxPrice,
  });

  final String? search;
  final List<String> conditions;
  final String? sortBy;
  final String? category;
  final String? gender;
  final String? clothingSize;
  final String? shoeSize;
  final double? minPrice;
  final double? maxPrice;

  bool isMinPriceHigherThanMaxPrice() {
    return minPrice != null && maxPrice != null && minPrice! >= maxPrice!;
  }

  Map<String, dynamic> toJson() {
    final tagsQuery = conditions.join(',');
    final Map<String, dynamic> queryParams = {};

    if (search?.isNotEmpty == true) {
      queryParams['search'] = search;
    }

    if (tagsQuery.isNotEmpty) {
      queryParams['tags'] = tagsQuery;
    }

    if (category?.isNotEmpty == true) {
      queryParams['categories'] = category;
    }

    if (sortBy?.isNotEmpty == true) {
      queryParams['sortBy'] = sortBy!.replaceAll(' ', '').capitalize();
    }

    if (minPrice != null || maxPrice != null) {
      queryParams['price'] = '{"min": ${minPrice ?? 0.0}, "max": ${maxPrice ?? 0.0}}';
    }

    if (gender?.isNotEmpty == true) {
      queryParams['gender'] = gender;
    }

    if (clothingSize?.isNotEmpty == true) {
      queryParams['size'] = clothingSize;
    }

    if (shoeSize?.isNotEmpty == true) {
      queryParams['size'] = shoeSize;
    }

    return queryParams;
  }

  Map<String, dynamic> toFilterJson() {
    final tagsQuery = conditions.join(',');
    final Map<String, dynamic> queryParams = {};

    if (search?.isNotEmpty == true) {
      queryParams['search'] = search;
    }

    if (tagsQuery.isNotEmpty) {
      queryParams['filters'] = tagsQuery;
    }

    if (category?.isNotEmpty == true) {
      queryParams['categories'] = category;
    }

    if (sortBy?.isNotEmpty == true) {
      queryParams['sortBy'] = sortBy!.replaceAll(' ', '').capitalize();
    }

    if (minPrice != null) {
      queryParams['minPrice'] = minPrice!.toString();
    }

    if (maxPrice != null) {
      queryParams['maxPrice'] = maxPrice!.toString();
    }

    if (gender?.isNotEmpty == true) {
      queryParams['gender'] = gender;
    }

    if (clothingSize?.isNotEmpty == true) {
      queryParams['clothingSize'] = clothingSize;
    }

    if (shoeSize?.isNotEmpty == true) {
      queryParams['shoeSize'] = shoeSize;
    }

    return queryParams;
  }

  FilterEntity copyWith({
    String? search,
    List<String>? conditions,
    String? sortBy,
    String? category,
    String? gender,
    String? clothingSize,
    String? shoeSize,
    double? minPrice,
    double? maxPrice,
  }) {
    return FilterEntity(
      search: search ?? this.search,
      conditions: conditions ?? this.conditions,
      sortBy: sortBy ?? this.sortBy,
      category: category ?? this.category,
      gender: gender ?? this.gender,
      clothingSize: clothingSize ?? this.clothingSize,
      shoeSize: shoeSize ?? this.shoeSize,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [
        search,
        conditions,
        sortBy,
        category,
        gender,
        clothingSize,
        shoeSize,
        minPrice,
        maxPrice,
      ];
}
