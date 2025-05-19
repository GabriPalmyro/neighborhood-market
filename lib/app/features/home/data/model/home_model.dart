import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/home/domain/entities/home_entity.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/domain/model/ad_banner_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/domain/model/filters_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/domain/model/shop_galerry_model.dart';

class HomeModel extends Equatable {
  const HomeModel({
    required this.adBanner,
    required this.filters,
    required this.trending,
    required this.mostWanted,
    required this.followedItems,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      adBanner: json['bannerAd'] != null
          ? AdBannerModel.fromJson(
              json['bannerAd'],
            )
          : null,
      filters: json['filters'] != null
          ? FiltersModel.fromJson(
              json['filters'],
            )
          : null,
      trending: json['trending'] != null
          ? ShopGalleryModel.fromJson(
              json['trending'],
              ShopGalleryType.trending,
            )
          : null,
      mostWanted: json['mostWanted'] != null
          ? ShopGalleryModel.fromJson(
              json['mostWanted'],
              ShopGalleryType.mostWanted,
            )
          : null,
      followedItems: json['followedUsersItems'] != null
          ? ShopGalleryModel.fromJson(
              json['followedUsersItems'],
              ShopGalleryType.followedItems,
            )
          : null,
    );
  }

  HomeEntity toEntity() {
    return HomeEntity(
      adBanner: adBanner,
      filters: filters,
      trending: trending,
      mostWanted: mostWanted,
      followedItems: followedItems,
    );
  }

  final AdBannerModel? adBanner;
  final FiltersModel? filters;
  final ShopGalleryModel? trending;
  final ShopGalleryModel? mostWanted;
  final ShopGalleryModel? followedItems;

  @override
  List<Object?> get props => [
        adBanner,
        filters,
        trending,
        mostWanted,
        followedItems,
      ];
}
