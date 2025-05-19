import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_profile_entity.dart';

class SellerProfileModel extends Equatable {
  const SellerProfileModel({
    required this.sellerName,
    required this.sellerImage,
    required this.sellerBackgroundImage,
    required this.sellerDescription,
    required this.sellerRating,
    required this.sellerListingCount,
    required this.sellerProducts,
    this.sellerId,
    this.isFollowing = false,
  });

  factory SellerProfileModel.fromJson(Map<String, dynamic> json) {
    return SellerProfileModel(
      sellerName: json['sellerName'],
      sellerImage: json['sellerImage'],
      sellerBackgroundImage: json['sellerBackgroundImage'],
      sellerDescription: json['sellerDescription'],
      sellerRating: (json['sellerRating'] is int)
          ? (json['sellerRating'] as int).toDouble()
          : json['sellerRating'] as double,
      sellerListingCount: json['sellerListingCount'],
      isFollowing: json['isFollowing'] ?? false,
      sellerProducts: json['sellerProducts'] != null
          ? (json['sellerProducts'] as List<dynamic>)
              .map(
                (item) => ProductGalleryItemModel.fromJson(item),
              )
              .toList()
          : [],
    );
  }

  final String? sellerId;
  final String sellerName;
  final String sellerImage;
  final String? sellerBackgroundImage;
  final String? sellerDescription;
  final double sellerRating;
  final int sellerListingCount;
  final bool isFollowing;
  final List<ProductGalleryItemModel> sellerProducts;

  SellerProfileEntity toEntity() {
    return SellerProfileEntity(
      sellerId: sellerId,
      sellerName: sellerName,
      sellerImage: sellerImage,
      sellerBackgroundImage: sellerBackgroundImage,
      sellerDescription: sellerDescription,
      sellerRating: sellerRating,
      sellerListingCount: sellerListingCount,
      isFollowing: isFollowing,
      sellerProducts: sellerProducts,
    );
  }

  @override
  List<Object?> get props => [
        sellerId,
        sellerName,
        sellerImage,
        sellerBackgroundImage,
        sellerDescription,
        sellerRating,
        sellerListingCount,
        sellerProducts,
        isFollowing,
      ];
}
