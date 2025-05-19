import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/star_review/star_review_style.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class LabelStarReviewItem extends Equatable {
  const LabelStarReviewItem({
    required this.label,
    required this.amount,
  });

  final String label;
  final int amount;

  @override
  List<Object?> get props => [
        label,
        amount,
      ];
}

class LabelStarReviewWidget extends StatelessWidget {
  const LabelStarReviewWidget({
    required this.rating,
    this.title,
    this.subtitle,
    this.totalReviews,
    this.showRatingLabel = true,
    this.items = const [],
    super.key,
  });

  final String? title;
  final bool showRatingLabel;
  final double rating;
  final String? subtitle;
  final int? totalReviews;
  final List<LabelStarReviewItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    const starReviewStyle = StarReviewStyle();
    const starNumbers = 5;
    const barHeight = 8.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null) ...[
          DSText(
            title!,
            customStyle: TextStyle(
              fontSize: theme.font.size.sm,
              fontWeight: theme.font.weight.medium,
            ),
          ),
          SizedBox(height: theme.spacing.inline.xxxs),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showRatingLabel) ...[
              DSText(
                rating.toStringAsFixed(1).replaceAll('.', ','),
                customStyle: TextStyle(
                  fontSize: theme.font.size.sm,
                  fontWeight: theme.font.weight.medium,
                ),
              ),
              SizedBox(width: theme.spacing.inline.xxxs),
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                starNumbers,
                (index) {
                  final isFull = index < rating.floor();
                  final isHalf = index < rating && index >= rating.floor();
                  return Icon(
                    isFull
                        ? Icons.star
                        : isHalf
                            ? Icons.star_half
                            : Icons.star_border,
                    size: 30,
                    color: isFull || isHalf ? const Color(0xFFFFCC00) : Colors.grey,
                  );
                },
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          SizedBox(height: theme.spacing.inline.xxs),
          DSText(
            subtitle!,
            customStyle: TextStyle(
              fontSize: theme.font.size.xxxs,
              color: theme.colors.neutral.dark.icon,
            ),
          ),
        ],
        if (items.isNotEmpty && totalReviews != null) ...[
          SizedBox(height: theme.spacing.inline.xxs),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                items.length,
                (index) {
                  final item = items[index];
                  final barSize = item.amount == 0 ? 0.0 : ((MediaQuery.sizeOf(context).width * 0.45) * item.amount) / totalReviews!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 20,
                        color: Color(0xFFFFCC00),
                      ),
                      SizedBox(width: theme.spacing.inline.xxxs),
                      DSText(
                        item.label,
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xxxs,
                          fontWeight: theme.font.weight.medium,
                        ),
                      ),
                      SizedBox(width: theme.spacing.inline.xxs),
                      Container(
                        width: barSize <= 0 ? 1 : barSize,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: starReviewStyle.barColor(index),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(width: theme.spacing.inline.xxxs),
                      DSText(
                        item.amount.toString(),
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xxxs,
                          fontWeight: theme.font.weight.medium,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}
