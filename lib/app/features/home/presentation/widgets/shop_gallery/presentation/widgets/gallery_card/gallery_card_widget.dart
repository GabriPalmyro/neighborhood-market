import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/badge/badge_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/common/extensions/string_extension.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/domain/model/shop_galerry_model.dart';

class GalleryCardWidget extends StatelessWidget {
  const GalleryCardWidget({
    required this.item,
    required this.navigator,
    this.onFavorite,
    super.key,
  });

  final ShopGalleryItemModel item;
  final AppNavigator navigator;
  final Function(bool)? onFavorite;

  @override
  Widget build(BuildContext context) {
    const double imageSize = 132.0;
    final tokens = DSTheme.getDesignTokensOf(context);
    return ClickableWidget(
      borderRadius: BorderRadius.circular(tokens.borders.radius.small),
      onTap: () {
        navigator.pushRoute(
          Routes.product,
          queryParameters: {
            'id': item.id,
          },
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: tokens.colors.neutral.light.pure,
          borderRadius: BorderRadius.circular(tokens.borders.radius.small),
          border: Border.all(
            color: tokens.colors.neutral.light.one,
            width: tokens.borderWidth.thin,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(tokens.borders.radius.small),
                topRight: Radius.circular(tokens.borders.radius.small),
              ),
              child: CachedNetworkImage(
                imageUrl: item.image ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: imageSize,
                errorWidget: (context, url, error) {
                  return Container(
                    height: imageSize,
                    width: double.infinity,
                    color: tokens.colors.neutral.light.one,
                    child: DSIcon(
                      icon: DSIcons.camera,
                      color: tokens.colors.neutral.light.icon,
                      size: DSIconSize.md,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: tokens.spacing.inline.xxs),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.inline.xxs,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: DSText(
                          (item.price ?? 0.0).toCurrency(),
                          maxLines: 1,
                          customStyle: TextStyle(
                            fontWeight: tokens.font.weight.semiBold,
                            fontSize: tokens.font.size.md,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClickableWidget(
                    borderRadius: BorderRadius.circular(tokens.borders.radius.circular),
                    onTap: () {
                      onFavorite?.call(item.isLiked);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: tokens.spacing.inline.xxxs,
                        bottom: tokens.spacing.inline.xxxs,
                        left: tokens.spacing.inline.xxxs,
                      ),
                      child: DSIcon(
                        icon: DSIcons.heartFilled,
                        color: item.isLiked ? tokens.colors.feedback.error : tokens.colors.neutral.dark.icon,
                        size: DSIconSize.md,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: tokens.spacing.inline.xxxs),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.inline.xxs,
              ),
              child: DSText(
                item.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                customStyle: TextStyle(
                  fontWeight: tokens.font.weight.medium,
                  fontSize: tokens.font.size.xxs,
                ),
              ),
            ),
            SizedBox(height: tokens.spacing.inline.xxs),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.inline.xxs,
              ),
              child: Wrap(
                spacing: tokens.spacing.inline.xxxs,
                runSpacing: tokens.spacing.inline.xxxs,
                children: item.tags.map(
                  (tag) {
                    return BadgeWidget(
                      label: tag.capitalize(),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
