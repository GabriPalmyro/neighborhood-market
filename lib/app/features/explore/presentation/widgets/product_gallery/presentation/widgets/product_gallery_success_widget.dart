import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_props.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';

class ProductGallerySuccessWidget extends StatelessWidget {
  const ProductGallerySuccessWidget({
    required this.entity,
    required this.navigator,
    required this.onTapLiked,
    super.key,
  });

  final ProductGalleryItemEntity entity;
  final AppNavigator navigator;
  final Function(String, bool) onTapLiked;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return ProductItemWidget(
      onTap: () {
        navigator.pushRoute(
          Routes.product,
          queryParameters: {
            'id': entity.id ?? '',
          },
        );
      },
      props: ProductItemProps(
        title: entity.title ?? '',
        badges: entity.tags,
        imageUrl: entity.image ?? '',
        price: entity.price,
        trailing: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: tokens.spacing.inline.xxs,
            vertical: tokens.spacing.inline.xxxs,
          ),
          child: ClickableWidget(
            borderRadius: BorderRadius.circular(tokens.borders.radius.circular),
            onTap: () {
              onTapLiked(entity.id ?? '', entity.isLiked ?? false);
            },
            child: Padding(
              padding: EdgeInsets.all(tokens.spacing.inline.xxxs),
              child: DSIcon(
                icon: DSIcons.heartFilled,
                color: entity.isLiked ?? false ? tokens.colors.feedback.error : tokens.colors.neutral.dark.icon,
                size: DSIconSize.md,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
