import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/domain/model/ad_banner_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/domain/model/filters_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/domain/model/shop_galerry_model.dart';

class HomeEntity extends Equatable {
  const HomeEntity({
    required this.adBanner,
    required this.filters,
    required this.trending,
    required this.mostWanted,
    required this.followedItems,
  });

  final AdBannerModel? adBanner;
  final FiltersModel? filters;
  final ShopGalleryModel? trending;
  final ShopGalleryModel? mostWanted;
  final ShopGalleryModel? followedItems;

  HomeEntity copyWith({
    AdBannerModel? adBanner,
    FiltersModel? filters,
    ShopGalleryModel? trending,
    ShopGalleryModel? mostWanted,
    ShopGalleryModel? followedItems,
  }) {
    return HomeEntity(
      adBanner: adBanner ?? this.adBanner,
      filters: filters ?? this.filters,
      trending: trending ?? this.trending,
      mostWanted: mostWanted ?? this.mostWanted,
      followedItems: followedItems ?? this.followedItems,
    );
  }

  @override
  List<Object?> get props => [
        adBanner,
        filters,
        trending,
        mostWanted,
        followedItems,
      ];
}
