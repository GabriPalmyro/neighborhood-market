import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_header_entity.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_rating_entity.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_review_card_entity.dart';

class SellerReviewEntity extends Equatable {
  const SellerReviewEntity({
    required this.header,
    required this.rating,
    required this.reviews,
    this.id,
  });

  final String? id;
  final SellerHeaderEntity header;
  final SellerRatingEntity rating;
  final List<SellerReviewCardEntity> reviews;

  SellerReviewEntity copyWith({
    String? id,
    SellerHeaderEntity? header,
    SellerRatingEntity? rating,
    List<SellerReviewCardEntity>? reviews,
  }) {
    return SellerReviewEntity(
      id: id ?? this.id,
      header: header ?? this.header,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
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
