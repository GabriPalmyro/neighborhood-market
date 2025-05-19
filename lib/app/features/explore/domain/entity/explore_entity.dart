// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/domain/model/ad_banner_model.dart';

class ExploreEntity extends Equatable {
  final List<ProductGalleryItemEntity> items;
  final AdBannerModel? adBanner;

  const ExploreEntity({
    required this.items,
    this.adBanner,
  });

  @override
  List<Object?> get props => [
        items,
        adBanner,
      ];
}
