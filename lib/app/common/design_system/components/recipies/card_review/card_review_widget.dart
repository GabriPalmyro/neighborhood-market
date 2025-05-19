import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/star_review/label_star_review_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/date_extension.dart';

class CardReviewWidget extends StatelessWidget {
  const CardReviewWidget({
    required this.reviewerImage,
    required this.reviewerName,
    required this.reviewRating,
    required this.reviewDate,
    required this.reviewContent,
    super.key,
  });

  final String reviewerImage;
  final String reviewerName;
  final int reviewRating;
  final String reviewDate;
  final String reviewContent;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.borders.radius.medium),
        border: Border.all(
          color: theme.colors.neutral.light.three,
          width: theme.borderWidth.thin,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.inline.xs),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(theme.borders.radius.circular),
                child: CachedNetworkImage(
                  imageUrl: reviewerImage,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => SizedBox(
                    height: 40,
                    width: 40,
                    child: CircleAvatar(
                      backgroundColor: theme.colors.neutral.dark.icon,
                      child: const DSIcon(
                        size: DSIconSize.sm,
                        icon: DSIcons.tag,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              reviewerName,
              customStyle: TextStyle(
                fontSize: theme.font.size.sm,
                fontWeight: theme.font.weight.semiBold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            LabelStarReviewWidget(
              rating: reviewRating.toDouble(),
              showRatingLabel: false,
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              DateTime.parse(reviewDate).toStringFull(),
              customStyle: TextStyle(
                fontSize: theme.font.size.xxxs,
                color: theme.colors.neutral.dark.three,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            DSText(
              reviewContent,
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.medium,
                color: theme.colors.neutral.dark.three,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
