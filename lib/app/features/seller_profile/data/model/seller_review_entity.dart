import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/seller_profile/data/model/seller_header_model.dart';
import 'package:neighborhood_market/app/features/seller_profile/data/model/seller_rating_model.dart';
import 'package:neighborhood_market/app/features/seller_profile/data/model/seller_review_card_model.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_review_entity.dart';

class SellerReviewModel extends Equatable {
  const SellerReviewModel({
    required this.header,
    required this.rating,
    required this.reviews,
    this.id,
  });

  factory SellerReviewModel.fromJson(Map<String, dynamic> json) {
    final SellerHeaderModel header = SellerHeaderModel.fromJson(json['header']);
    final SellerRatingModel rating = SellerRatingModel.fromJson(json['rating']);

    final List<SellerReviewCardModel> reviews = [];
    
    try {
      for (final item in json['reviews'] as List<dynamic>) {
        reviews.add(SellerReviewCardModel.fromJson(item));
      }
    } catch (_) {}

    return SellerReviewModel(
      header: header,
      rating: rating,
      reviews: reviews,
    );
  }

  final String? id;
  final SellerHeaderModel header;
  final SellerRatingModel rating;
  final List<SellerReviewCardModel> reviews;

  SellerReviewEntity toEntity() {
    return SellerReviewEntity(
      id: id,
      header: header.toEntity(),
      rating: rating.toEntity(),
      reviews: reviews.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        header,
        rating,
        reviews,
      ];
}
