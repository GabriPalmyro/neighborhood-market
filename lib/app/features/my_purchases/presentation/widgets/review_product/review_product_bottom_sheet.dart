import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/star_review/star_review_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text_field/text_field_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/review_product/review_product_cubit.dart';

class ReviewProductBottomSheet extends StatefulWidget {
  const ReviewProductBottomSheet({
    required this.sellerId,
    required this.productId,
    required this.productName,
    required this.onReviewSent,
    super.key,
  });

  final String sellerId;
  final String productId;
  final String productName;
  final VoidCallback onReviewSent;

  @override
  State<ReviewProductBottomSheet> createState() => _ReviewProductBottomSheetState();
}

class _ReviewProductBottomSheetState extends State<ReviewProductBottomSheet> {
  late TextEditingController commentController;

  int rating = 0;

  @override
  void initState() {
    commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void setRating(int newRating) {
    setState(() {
      rating = newRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (context) => GetIt.I.get<ReviewProductCubit>(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          theme.spacing.inline.xs,
          theme.spacing.inline.xs,
          theme.spacing.inline.xs,
          MediaQuery.of(context).viewInsets.bottom + theme.spacing.inline.xs,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DSText(
              'Regarding ${widget.productName}',
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.icon,
                fontSize: theme.font.size.xxxs,
                fontWeight: theme.font.weight.medium,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              'How was your purchase?',
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                fontSize: theme.font.size.md,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            DSText(
              'Your review helps us improve our service and offer better experiencies.',
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.icon,
                fontSize: theme.font.size.xxxs,
                fontWeight: theme.font.weight.medium,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: StarReviewWidget(
                  rating: rating,
                  onRatingChanged: setRating,
                ),
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            DSTextField(
              controller: commentController,
              label: 'Add a comment',
              maxLines: null,
              expandable: true,
            ),
            SizedBox(height: theme.spacing.inline.xs),
            BlocConsumer<ReviewProductCubit, ReviewProductState>(
              listener: (context, state) {
                if (state is ReviewProductLoaded) {
                  widget.onReviewSent();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSuccessSnackBar(
                    context,
                    content: 'Review sent successfully.',
                  );
                }

                if (state is ReviewProductError) {
                  showDSBottomSheet(
                    context: context,
                    child: ErrorBottomSheetWidget(
                      message: state.message,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return DSButton(
                  label: 'Submit Review',
                  isLoading: state is ReviewProductLoading,
                  onPressed: () {
                    context.read<ReviewProductCubit>().loadReviewProduct(
                          widget.sellerId,
                          widget.productId,
                          commentController.text,
                          rating,
                        );
                  },
                );
              },
            ),
            SizedBox(height: theme.spacing.inline.sm),
          ],
        ),
      ),
    );
  }
}
