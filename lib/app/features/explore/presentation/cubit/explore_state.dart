import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/core/core.dart';
import 'package:neighborhood_market/app/features/explore/domain/entity/filter_entity.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/domain/model/ad_banner_model.dart';

enum ExploreStatus { initial, loading, success, failure }

final class ExploreState extends Equatable {
  const ExploreState({
    this.status = ExploreStatus.initial,
    this.products = const <ProductGalleryItemEntity>[],
    this.page = AppConsts.kInitialPage,
    this.hasReachedMax = false,
    this.filters = const FilterEntity(),
    this.adBanner,
  });

  final ExploreStatus status;
  final List<ProductGalleryItemEntity> products;
  final int page;
  final bool hasReachedMax;

  // filters
  final FilterEntity filters;

  final AdBannerModel? adBanner;

  bool hasFilters() {
    return filters.category != null ||
        filters.conditions.isNotEmpty ||
        filters.sortBy?.isNotEmpty == true ||
        filters.search?.isNotEmpty == true ||
        filters.gender?.isNotEmpty == true ||
        filters.clothingSize?.isNotEmpty == true ||
        filters.shoeSize?.isNotEmpty == true ||
        filters.minPrice != null ||
        filters.maxPrice != null;
  }

  ExploreState copyWith({
    ExploreStatus? status,
    List<ProductGalleryItemEntity>? products,
    int? page,
    bool? hasReachedMax,
    List<String>? tags,
    String? category,
    String? sortBy,
    String? searchQuery,
    String? gender,
    String? clothingSize,
    String? shoeSize,
    double? minPrice,
    double? maxPrice,
    AdBannerModel? adBanner,
  }) {
    return ExploreState(
      status: status ?? this.status,
      products: products ?? this.products,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      filters: filters.copyWith(
        category: category,
        conditions: tags,
        sortBy: sortBy,
        search: searchQuery,
        gender: gender,
        clothingSize: clothingSize,
        shoeSize: shoeSize,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
      adBanner: adBanner ?? this.adBanner,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        page,
        hasReachedMax,
        filters,
        adBanner,
      ];
}
