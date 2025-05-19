import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_props.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/date_extension.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_order_entity.dart';

class OrderCardSuccessWidget extends StatelessWidget {
  const OrderCardSuccessWidget({required this.order, super.key});

  final PurchaseOrderEntity order;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.neutral.light.pure,
          borderRadius: BorderRadius.circular(theme.borders.radius.large),
          boxShadow: [theme.shadow.normal],
        ),
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.inline.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (order.orderNumber?.isNotEmpty == true) ...[
                const DSText(
                  'Order Number',
                ),
                DSText(
                  order.orderNumber!,
                  customStyle: TextStyle(
                    fontSize: theme.font.size.lg,
                    fontWeight: theme.font.weight.extraBold,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.sm),
              ],
              DSText(
                'Delivery Address',
                customStyle: TextStyle(
                  color: theme.colors.neutral.dark.three,
                  fontWeight: theme.font.weight.semiBold,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xxxs),
              DSText(
                order.deliveryAddress,
                customStyle: TextStyle(
                  color: theme.colors.neutral.dark.three,
                ),
              ),
              SizedBox(height: theme.spacing.inline.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DSText(
                        'Created',
                        customStyle: TextStyle(
                          color: theme.colors.neutral.dark.three,
                          fontWeight: theme.font.weight.semiBold,
                        ),
                      ),
                      SizedBox(height: theme.spacing.inline.xxxs),
                      DSText(
                        order.createdAt.toStringDate(),
                        customStyle: TextStyle(
                          color: theme.colors.neutral.dark.three,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DSText(
                        'Estimated Delivery',
                        customStyle: TextStyle(
                          color: theme.colors.neutral.dark.three,
                          fontWeight: theme.font.weight.semiBold,
                        ),
                      ),
                      SizedBox(height: theme.spacing.inline.xxxs),
                      DSText(
                        order.deliveryDate,
                        customStyle: TextStyle(
                          color: theme.colors.neutral.dark.three,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.inline.sm),
              DSText(
                'Your Order',
                customStyle: TextStyle(
                  fontSize: theme.font.size.xs,
                  color: theme.colors.neutral.dark.three,
                  fontWeight: theme.font.weight.semiBold,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xxs),
              ProductItemWidget(
                props: ProductItemProps(
                  title: order.product.title ?? '',
                  badges: order.product.tags,
                  imageUrl: order.product.image ?? '',
                  price: order.product.price,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
