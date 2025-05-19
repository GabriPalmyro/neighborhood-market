import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_review_card_entity.dart';

class SellerReviewCardModel extends Equatable {
  const SellerReviewCardModel({
    required this.reviewerName,
    required this.reviewerImage,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory SellerReviewCardModel.fromJson(Map<String, dynamic> json) {
    return SellerReviewCardModel(
      reviewerName: json['username'],
      reviewerImage: json['image'],
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
    );
  }

  final String reviewerName;
  final String reviewerImage;
  final int rating;
  final String comment;
  final String date;

  SellerReviewCardEntity toEntity() {
    return SellerReviewCardEntity(
      reviewerName: reviewerName,
      reviewerImage: reviewerImage,
      rating: rating,
      comment: comment,
      date: date,
    );
  }

  @override
  List<Object> get props => [
        reviewerName,
        reviewerImage,
        rating,
        comment,
        date,
      ];
}
