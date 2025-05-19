import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/domain/model/ad_banner_model.dart';

class WishlistEntity extends Equatable {
  const WishlistEntity({
    required this.items,
    this.adBanner,
  });
  
  final AdBannerModel? adBanner;
  final List<ProductGalleryItemEntity> items;

  WishlistEntity copyWith({
    AdBannerModel? adBanner,
    List<ProductGalleryItemEntity>? items,
  }) {
    return WishlistEntity(
      adBanner: adBanner ?? this.adBanner,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [adBanner, items];
}