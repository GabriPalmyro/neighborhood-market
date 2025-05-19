import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/domain/model/shop_galerry_model.dart';
import 'package:neighborhood_market/app/features/product/data/model/seller_model.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/action_button_type.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/product_entity.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/seller_entity.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.tags,
    this.isLiked = false,
    this.recommended,
    this.seller,
    this.actionType,
    this.brand,
    this.tailoredDetails,
    this.flaws,
    this.gender,
    this.size,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['name'],
      description: json['description'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] as double,
      isLiked: json['isLiked'] ?? false,
      images: List<String>.from(json['images']?.map((image) => image ?? '') ?? []),
      tags: List<String>.from(json['tags']?.map((tag) => tag ?? '') ?? []),
      recommended: json['recommended'] != null ? ShopGalleryModel.fromJson(json['recommended'], null) : null,
      seller: json['seller'] != null ? SellerModel.fromJson(json['seller']) : null,
      actionType: json['actionType'] != null ? ActionButtonType.fromString(json['actionType']) : null,
      brand: json['brand'] as String?,
      tailoredDetails: json['tailoredDetails'] as String?,
      flaws: json['flaws'] as String?,
      size: json['size'] as String?,
      gender: json['gender'] as String?,
    );
  }

  final String id;
  final String title;
  final String description;
  final double price;
  final bool isLiked;
  final List<String> images;
  final List<String> tags;
  final ShopGalleryModel? recommended;
  final SellerEntity? seller;
  final ActionButtonType? actionType;
  final String? brand;
  final String? tailoredDetails;
  final String? flaws;
  final String? gender;
  final String? size;

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      isLiked: isLiked,
      images: images,
      tags: tags,
      recommended: recommended,
      seller: seller,
      actionType: actionType,
      brand: brand,
      tailoredDetails: tailoredDetails,
      flaws: flaws,
      size: size,
      gender: gender,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        isLiked,
        images,
        tags,
        recommended,
        seller,
        actionType,
        brand,
        tailoredDetails,
        flaws,
        size,
        gender,
      ];
}
