import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/badge/badge_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_props.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/common/extensions/string_extension.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    required this.props,
    this.onTap,
    super.key,
  });

  final ProductItemProps props;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const double productHeightSize = 126.0;
    final tokens = DSTheme.getDesignTokensOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [tokens.shadow.normal],
      ),
      child: ClickableWidget(
        borderRadius: BorderRadius.circular(tokens.borders.radius.small),
        onTap: onTap,
        child: Ink(
          height: productHeightSize,
          width: double.infinity,
          decoration: BoxDecoration(
            color: tokens.colors.neutral.light.pure,
            borderRadius: BorderRadius.circular(tokens.borders.radius.small),
            border: Border.all(
              color: tokens.colors.neutral.light.one,
              width: tokens.borderWidth.thin,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (props.imageUrl != null) ...[
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(tokens.borders.radius.small),
                      bottomLeft: Radius.circular(tokens.borders.radius.small),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: props.imageUrl!,
                      fit: BoxFit.cover,
                      height: productHeightSize,
                      placeholder: (context, url) => const Center(
                        child: ShimmerComponent(
                          width: double.infinity,
                          height: productHeightSize,
                          hasBorderRadius: false,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Container(
                          height: productHeightSize,
                          width: double.infinity,
                          color: tokens.colors.neutral.light.one,
                          child: DSIcon(
                            icon: DSIcons.camera,
                            color: tokens.colors.neutral.light.icon,
                            size: DSIconSize.md,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: productHeightSize,
                    color: tokens.colors.neutral.light.one,
                    child: Center(
                      child: DSIcon(
                        icon: DSIcons.camera,
                        color: tokens.colors.neutral.light.icon,
                        size: DSIconSize.lg,
                      ),
                    ),
                  ),
                ),
              ],
              SizedBox(width: tokens.spacing.inline.xxxs),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: tokens.spacing.inline.xxs),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: tokens.spacing.inline.xxs,
                                  ),
                                  child: DSText(
                                    props.title,
                                    customStyle: TextStyle(
                                      fontWeight: tokens.font.weight.medium,
                                      fontSize: tokens.font.size.xxs,
                                    ),
                                  ),
                                ),
                                SizedBox(height: tokens.spacing.inline.xxxs),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: tokens.spacing.inline.xxs,
                                  ),
                                  child: Wrap(
                                    spacing: tokens.spacing.inline.xxxs,
                                    runSpacing: tokens.spacing.inline.xxxs,
                                    children: props.badges.map(
                                      (badge) {
                                        return BadgeWidget(
                                          label: badge.capitalize(),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (props.trailing != null) props.trailing!,
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: tokens.spacing.inline.xxs,
                        right: tokens.spacing.inline.xxs,
                        bottom: tokens.spacing.inline.xxs,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (props.views != null) ...[
                            Padding(
                              padding: EdgeInsets.only(right: tokens.spacing.inline.xxxs),
                              child: DSIcon(
                                icon: DSIcons.union,
                                color: tokens.colors.neutral.light.three,
                                size: DSIconSize.sm,
                              ),
                            ),
                            DSText(
                              '${props.views} views',
                              customStyle: TextStyle(
                                color: tokens.colors.neutral.dark.icon,
                                fontWeight: tokens.font.weight.medium,
                                fontSize: tokens.font.size.xxxs,
                              ),
                            ),
                            const Spacer(),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: DSText(
                                  '\$',
                                  customStyle: TextStyle(
                                    fontWeight: tokens.font.weight.semiBold,
                                    fontSize: tokens.font.size.xs,
                                    decoration: props.isValueCheck ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                              ),
                              DSText(
                                (props.price ?? 0.0).toCurrencyWithoutSymbol(),
                                customStyle: TextStyle(
                                  fontWeight: tokens.font.weight.semiBold,
                                  fontSize: tokens.font.size.md,
                                  decoration: props.isValueCheck ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
