import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/user_search_entity.dart';
import 'package:neighborhood_market/app/features/create_product/utils/product_conditions.dart';

class CreateProductModel extends Equatable {
  const CreateProductModel({
    this.title = '',
    this.description,
    this.price,
    this.tag,
    this.category,
    this.images,
    this.isTailored = false,
    this.details,
    this.seller,
    this.brand,
    this.hasFlaws = false,
    this.flaws,
    this.gender,
    this.size,
  });

  final String title;
  final String? description;
  final double? price;
  final String? tag;
  final CategoryEntity? category;
  final List<Uint8List>? images;
  final bool isTailored;
  final String? details;
  final UserSearchEntity? seller;
  final String? brand;
  final bool hasFlaws;
  final String? flaws;
  final ProductGender? gender;
  final String? size;

  CreateProductModel copyWith({
    String? title,
    String? description,
    double? price,
    String? tag,
    CategoryEntity? category,
    List<Uint8List>? images,
    bool? isTailored,
    String? details,
    UserSearchEntity? seller,
    String? brand,
    bool? hasFlaws,
    String? flaws,
    ProductGender? gender,
    String? size,
  }) {
    return CreateProductModel(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      tag: tag ?? this.tag,
      category: category ?? this.category,
      images: images ?? this.images,
      isTailored: isTailored ?? this.isTailored,
      details: details ?? this.details,
      seller: seller ?? this.seller,
      brand: brand ?? this.brand,
      hasFlaws: hasFlaws ?? this.hasFlaws,
      flaws: flaws ?? this.flaws,
      gender: gender ?? this.gender,
      size: size ?? this.size,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        price,
        tag,
        category,
        images,
        isTailored,
        details,
        seller,
        brand,
        hasFlaws,
        flaws,
        gender,
        size,
      ];
}
