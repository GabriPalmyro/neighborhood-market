import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/domain/model/shop_galerry_model.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/action_button_type.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/seller_entity.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
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
  final String? size;
  final String? gender;

  ProductEntity copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    bool? isLiked,
    List<String>? images,
    List<String>? tags,
    ShopGalleryModel? recommended,
    SellerEntity? seller,
    ActionButtonType? actionType,
    String? brand,
    String? tailoredDetails,
    String? flaws,
    String? size,
    String? gender,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      isLiked: isLiked ?? this.isLiked,
      images: images ?? this.images,
      tags: tags ?? this.tags,
      recommended: recommended ?? this.recommended,
      seller: seller ?? this.seller,
      actionType: actionType ?? this.actionType,
      brand: brand ?? this.brand,
      tailoredDetails: tailoredDetails ?? this.tailoredDetails,
      flaws: flaws ?? this.flaws,
      gender: gender ?? this.gender,
      size: size ?? this.size,
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
