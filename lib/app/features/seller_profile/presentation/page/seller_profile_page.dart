import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/loading/loading_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_props.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/list_item/list_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/star_review/label_star_review_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/model/header_model.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/presentation/widgets/header_profile_success.dart';
import 'package:neighborhood_market/app/features/seller_profile/presentation/cubit/seller_profile_cubit.dart';

class SellerProfilePage extends StatelessWidget {
  const SellerProfilePage({
    required this.sellerId,
    required this.appNavigator,
    super.key,
  });

  final String sellerId;
  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      appBar: TopbarWidget.defaultTopBar(
        centerTitle: false,
        title: DSText(
          'Profile',
          customStyle: TextStyle(
            fontWeight: theme.font.weight.semiBold,
            fontSize: theme.font.size.xs,
          ),
        ),
      ),
      body: BlocBuilder<SellerProfileCubit, SellerProfileState>(
        builder: (context, state) {
          return FadeSwitcherState<SellerProfileState, SellerProfileLoaded, SellerProfileError, SellerProfileLoading>(
            error: (error) => MainPageErrorWidget(
              onRetry: () {
                context.read<SellerProfileCubit>().getSellerProfile(
                      error.sellerId,
                    );
              },
            ),
            loading: (_) => const Center(
              child: LoadingWidget(),
            ),
            result: (success) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'header',
                      child: HeaderProfileSuccessWidget(
                        id: success.sellerProfile.sellerId,
                        onFollow: (follow, _) {
                          if (success.sellerProfile.sellerId != null) {
                            if (follow) {
                              context.read<SellerProfileCubit>().followSeller(
                                    success.sellerProfile.sellerId!,
                                  );
                            } else {
                              context.read<SellerProfileCubit>().unfollowSeller(
                                    success.sellerProfile.sellerId!,
                                  );
                            }
                          }
                        },
                        model: HeaderModel(
                          username: success.sellerProfile.sellerName,
                          description: success.sellerProfile.sellerDescription,
                          imageProfile: success.sellerProfile.sellerImage,
                          imageBackground: success.sellerProfile.sellerBackgroundImage,
                          isFollowing: success.sellerProfile.isFollowing,
                        ),
                      ),
                    ),
                    LabelStarReviewWidget(
                      title: 'Average Rating',
                      rating: success.sellerProfile.sellerRating,
                    ),
                    SizedBox(height: theme.spacing.inline.xs),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      child: DSButton(
                        label: 'See Reviews',
                        onPressed: () {
                          appNavigator.pushRoute(
                            Routes.sellerReviews,
                            queryParameters: {
                              'sellerId': sellerId,
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: theme.spacing.inline.sm),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.inline.xs,
                      ),
                      child: const ThemeDividerWidget(),
                    ),
                    SizedBox(height: theme.spacing.inline.sm),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.inline.xs,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            theme.borders.radius.medium,
                          ),
                          border: Border.all(
                            color: theme.colors.neutral.light.two,
                            width: theme.borderWidth.thin,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: theme.spacing.inline.xs,
                            vertical: theme.spacing.inline.xxs,
                          ),
                          child: ListItemWidget(
                            title: '${success.sellerProfile.sellerListingCount} Listings',
                            subtitle: 'Published in the last 90 days',
                            leading: const DSIcon(
                              icon: DSIcons.box,
                              size: DSIconSize.lg,
                            ),
                            isCentered: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: theme.spacing.inline.sm),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.inline.xs,
                      ),
                      child: const ThemeDividerWidget(),
                    ),
                    SizedBox(height: theme.spacing.inline.xs),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.inline.xs,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: DSText(
                              'Seller Listings',
                              customStyle: TextStyle(
                                fontWeight: theme.font.weight.semiBold,
                                fontSize: theme.font.size.xs,
                              ),
                            ),
                          ),
                          SizedBox(height: theme.spacing.inline.xxs),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: success.sellerProfile.sellerProducts.length,
                            itemBuilder: (_, index) {
                              final item = success.sellerProfile.sellerProducts[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: theme.spacing.inline.xs,
                                ),
                                child: ProductItemWidget(
                                  props: ProductItemProps(
                                    title: item.title ?? '',
                                    price: item.price,
                                    imageUrl: item.image ?? '',
                                    badges: item.tags,
                                  ),
                                  onTap: () {
                                    appNavigator.pushRoute(
                                      Routes.product,
                                      queryParameters: {
                                        'id': item.id ?? '',
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
