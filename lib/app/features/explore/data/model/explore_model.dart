// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/explore/domain/entity/explore_entity.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/domain/model/ad_banner_model.dart';

class ExploreModel extends Equatable {
  final List<ProductGalleryItemModel> items;
  final AdBannerModel? adBanner;

  const ExploreModel({
    required this.items,
    this.adBanner,
  });

  factory ExploreModel.fromJson(Map<String, dynamic> json) {
    return ExploreModel(
      items: (json['items']['data'] as List<dynamic>)
          .map(
            (item) => ProductGalleryItemModel.fromJson(item),
          )
          .toList(),
      adBanner: json['bannerAd'] != null
          ? AdBannerModel.fromJson(
              json['bannerAd'],
            )
          : null,
    );
  }

  ExploreEntity toEntity() {
    return ExploreEntity(
      items: items.map((item) => item.toEntity()).toList(),
      adBanner: adBanner,
    );
  }

  @override
  List<Object?> get props => [
        items,
        adBanner,
      ];
}
