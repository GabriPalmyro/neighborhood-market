import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/card_review/card_review_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_review_card_entity.dart';

class CardReviewsWidget extends StatelessWidget {
  const CardReviewsWidget({required this.reviews, super.key});

  final List<SellerReviewCardEntity> reviews;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.inline.xs,
      ),
      shrinkWrap: true,
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: theme.spacing.inline.xs,
          ),
          child: CardReviewWidget(
            reviewerImage: review.reviewerImage,
            reviewerName: review.reviewerName,
            reviewRating: review.rating,
            reviewDate: review.date,
            reviewContent: review.comment,
          ),
        );
      },
    );
  }
}
