import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';

class SellerProfileEntity extends Equatable {
  const SellerProfileEntity({
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

  final String? sellerId;
  final String sellerName;
  final String sellerImage;
  final String? sellerBackgroundImage;
  final String? sellerDescription;
  final double sellerRating;
  final int sellerListingCount;
  final bool isFollowing;
  final List<ProductGalleryItemModel> sellerProducts;

  SellerProfileEntity copyWith({
    String? sellerId,
    String? sellerName,
    String? sellerImage,
    String? sellerBackgroundImage,
    String? sellerDescription,
    double? sellerRating,
    int? sellerListingCount,
    bool? isFollowing,
    List<ProductGalleryItemModel>? sellerProducts,
  }) {
    return SellerProfileEntity(
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerImage: sellerImage ?? this.sellerImage,
      sellerBackgroundImage: sellerBackgroundImage ?? this.sellerBackgroundImage,
      sellerDescription: sellerDescription ?? this.sellerDescription,
      sellerRating: sellerRating ?? this.sellerRating,
      sellerListingCount: sellerListingCount ?? this.sellerListingCount,
      sellerProducts: sellerProducts ?? this.sellerProducts,
      isFollowing: isFollowing ?? this.isFollowing,
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
