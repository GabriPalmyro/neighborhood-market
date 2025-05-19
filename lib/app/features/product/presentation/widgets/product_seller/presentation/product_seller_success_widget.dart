import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/badge/badge_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/following/utils/following_strings.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/seller_entity.dart';
import 'package:neighborhood_market/app/features/product/presentation/cubit/product_details_cubit.dart';

class ProductSellerSuccessWidget extends StatelessWidget {
  const ProductSellerSuccessWidget({
    required this.seller,
    required this.appNavigator,
    super.key,
  });

  final SellerEntity seller;
  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText(
          'About the seller',
          customStyle: TextStyle(
            fontWeight: theme.font.weight.semiBold,
          ),
        ),
        SizedBox(height: theme.spacing.inline.xs),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              theme.borders.radius.large,
            ),
            border: Border.all(
              color: theme.colors.neutral.light.two,
              width: theme.borderWidth.thin,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.inline.sm,
            vertical: theme.spacing.inline.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    theme.borders.radius.circular,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: seller.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => SizedBox(
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                        backgroundColor: theme.colors.neutral.dark.icon,
                        child: const DSIcon(
                          icon: DSIcons.tag,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: theme.spacing.inline.xxs),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DSText(
                    seller.name,
                    customStyle: TextStyle(
                      fontWeight: theme.font.weight.semiBold,
                      fontSize: theme.font.size.xs,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: theme.spacing.inline.xxxs),
                  DSIcon(
                    icon: DSIcons.check,
                    size: DSIconSize.sm,
                    color: theme.colors.brand.secondary,
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.inline.xxs),
              SelectBadgeWidget(
                size: BadgeSize.small,
                label: seller.isFollowing ? FollowingStrings.unfollow : FollowingStrings.follow,
                onTap: () {
                  if(seller.isFollowing) {
                    context.read<ProductDetailsCubit>().unfollowSeller();
                  } else {
                    context.read<ProductDetailsCubit>().followSeller();
                  }
                },
                isSelected: seller.isFollowing,
              ),
              SizedBox(height: theme.spacing.inline.xxs),
              if (seller.description?.isNotEmpty == true) ...[
                DSText(
                  seller.description!,
                  customStyle: TextStyle(
                    fontWeight: theme.font.weight.medium,
                    fontSize: theme.font.size.xxxs,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: theme.spacing.inline.xxs),
              ],
              SizedBox(height: theme.spacing.inline.xxs),
              DSButton(
                label: 'View Profile',
                size: DSButtonSize.sm,
                onPressed: () {
                  appNavigator.pushRoute(
                    Routes.sellerProfile,
                    queryParameters: {
                      'sellerId': seller.id,
                      'sellerName': seller.name,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
