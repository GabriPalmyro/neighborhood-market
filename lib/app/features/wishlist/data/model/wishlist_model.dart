import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/domain/model/ad_banner_model.dart';
import 'package:neighborhood_market/app/features/wishlist/domain/entities/wishlist_entity.dart';

class WishlistModel extends Equatable {
  const WishlistModel({
    required this.items,
    this.adBanner,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      items: (json['wishlist'] as List<dynamic>)
          .map(
            (item) => ProductGalleryItemModel.fromJson(item).copyWith(
              isLiked: true,
            ),
          )
          .toList(),
      adBanner: json['bannerAd'] == null ? null : AdBannerModel.fromJson(json['bannerAd']),
    );
  }

  final AdBannerModel? adBanner;
  final List<ProductGalleryItemModel> items;

  WishlistEntity toEntity() {
    return WishlistEntity(
      items: items.map((item) => item.toEntity()).toList(),
      adBanner: adBanner,
    );
  }

  @override
  List<Object?> get props => [adBanner, items];
}
