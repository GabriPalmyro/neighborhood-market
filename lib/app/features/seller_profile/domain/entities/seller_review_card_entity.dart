import 'package:equatable/equatable.dart';

class SellerReviewCardEntity extends Equatable {
  const SellerReviewCardEntity({
    required this.reviewerName,
    required this.reviewerImage,
    required this.rating,
    required this.comment,
    required this.date,
  });

  final String reviewerName;
  final String reviewerImage;
  final int rating;
  final String comment;
  final String date;

  @override
  List<Object> get props => [
        reviewerName,
        reviewerImage,
        rating,
        comment,
        date,
      ];
}
