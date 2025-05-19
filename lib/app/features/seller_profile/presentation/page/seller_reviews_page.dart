import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/loading/loading_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/star_review/label_star_review_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/model/header_model.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/presentation/widgets/header_profile_success.dart';
import 'package:neighborhood_market/app/features/seller_profile/presentation/cubit/seller_reviews_cubit.dart';
import 'package:neighborhood_market/app/features/seller_profile/presentation/widgets/card_reviews/card_reviews_widget.dart';

class SellerReviewsPage extends StatelessWidget {
  const SellerReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      appBar: TopbarWidget.defaultTopBar(
        centerTitle: false,
        title: DSText(
          'Reviews',
          customStyle: TextStyle(
            fontWeight: theme.font.weight.semiBold,
            fontSize: theme.font.size.xs,
          ),
        ),
      ),
      body: BlocBuilder<SellerReviewsCubit, SellerReviewsState>(
        builder: (context, state) {
          return FadeSwitcherState<SellerReviewsState, SellerReviewsLoaded, SellerReviewsError, SellerReviewsLoading>(
            loading: (_) => const LoadingWidget(),
            error: (error) => MainPageErrorWidget(
              onRetry: () {
                context.read<SellerReviewsCubit>().getSellerReviews(
                      error.sellerId,
                    );
              },
            ),
            result: (success) {
              final rating = success.sellerReview.rating;
              final reviews = success.sellerReview.reviews;
              final seller = success.sellerReview.header;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderProfileSuccessWidget(
                      id: success.sellerReview.id,
                      onFollow: (follow, _) {
                        if (success.sellerReview.id != null) {
                          if (follow) {
                            context.read<SellerReviewsCubit>().followSeller(
                                  success.sellerReview.id!,
                                );
                          } else {
                            context.read<SellerReviewsCubit>().unfollowSeller(
                                  success.sellerReview.id!,
                                );
                          }
                        }
                      },
                      model: HeaderModel(
                        username: seller.username,
                        imageProfile: seller.imageProfile,
                        description: seller.description,
                        imageBackground: seller.imageBackground,
                        isFollowing: seller.isFollowing,
                      ),
                    ),
                    SizedBox(height: theme.spacing.inline.xxs),
                    DSText(
                      rating.total.toString(),
                      customStyle: TextStyle(
                        fontSize: theme.font.size.lg,
                        fontWeight: theme.font.weight.semiBold,
                      ),
                    ),
                    DSText(
                      'Total Reviews',
                      customStyle: TextStyle(
                        fontSize: theme.font.size.xs,
                      ),
                    ),
                    SizedBox(height: theme.spacing.inline.xs),
                    LabelStarReviewWidget(
                      title: 'Average Rating',
                      rating: rating.average,
                      subtitle: 'Average Rating on this year',
                      totalReviews: rating.total,
                      items: rating.averageStarItems.map(
                        (e) {
                          return LabelStarReviewItem(
                            amount: e.value,
                            label: e.label,
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(height: theme.spacing.inline.sm),
                    CardReviewsWidget(reviews: reviews),
                    SizedBox(height: theme.spacing.inline.xl),
                  ],
                ),
              );
            },
            state: state,
          );
        },
      ),
    );
  }
}
