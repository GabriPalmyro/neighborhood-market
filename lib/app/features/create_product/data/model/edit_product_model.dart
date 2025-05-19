import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/create_product/data/model/category_model.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';
import 'package:neighborhood_market/app/features/create_product/utils/product_conditions.dart';

class EditProductModel extends Equatable {
  const EditProductModel({
    this.title = '',
    this.description,
    this.price,
    this.tags,
    this.category,
    this.images,
    this.brand,
    this.tailoredDetails,
    this.isTailored = false,
    this.allowOffers = false,
    this.details,
    this.flaws,
    this.gender,
    this.size,
  });

  factory EditProductModel.fromJson(Map<String, dynamic> json) {
    return EditProductModel(
      title: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] is int?) ? (json['price'] as int).toDouble() : json['price'] as double?,
      tags: (json['tags'] as List?)?.map((e) => e as String).toList(),
      category: CategoryModel.fromJson(json).toEntity(),
      images: (json['images'] as List?)?.map((e) => e as String).toList(),
      isTailored: json['tailored'] as bool? ?? false,
      details: json['tailoredDetails'] as String?,
      allowOffers: json['acceptOffer'] as bool? ?? false,
      brand: json['brand'] as String?,
      tailoredDetails: json['tailoredDetails'] as String?,
      flaws: json['flaws'] as String?,
      gender: json['gender'] != null ? ProductGender.fromString(json['gender']) : null,
      size: json['size'] as String?,
    );
  }

  final String title;
  final String? description;
  final double? price;
  final List<String>? tags;
  final CategoryEntity? category;
  final List<String>? images;
  final String? brand;
  final bool isTailored;
  final String? tailoredDetails;
  final String? details;
  final bool allowOffers;
  final String? flaws;
  final ProductGender? gender;
  final String? size;

  EditProductModel copyWith({
    String? title,
    String? description,
    double? price,
    List<String>? tags,
    CategoryEntity? category,
    List<String>? images,
    bool? isTailored,
    String? details,
    bool? allowOffers,
    String? brand,
    String? tailoredDetails,
    String? flaws,
    ProductGender? gender,
    String? size,
  }) {
    return EditProductModel(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      images: images ?? this.images,
      isTailored: isTailored ?? this.isTailored,
      details: details ?? this.details,
      allowOffers: allowOffers ?? this.allowOffers,
      brand: brand ?? this.brand,
      tailoredDetails: tailoredDetails ?? this.tailoredDetails,
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
        tags,
        category,
        images,
        isTailored,
        details,
        allowOffers,
        brand,
        tailoredDetails,
        flaws,
        gender,
        size,
      ];
}
