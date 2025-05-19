import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/product_order/product_payment_order_cubit.dart';

class PaymentResumeWidget extends StatelessWidget {
  const PaymentResumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<ProductPaymentOrderCubit, ProductPaymentOrderState>(
      builder: (context, state) {
        state as ProductPaymentOrderLoaded;
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colors.neutral.light.two,
              width: theme.borderWidth.thin,
            ),
            borderRadius: BorderRadius.circular(
              theme.borders.radius.medium,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.xs,
              vertical: theme.spacing.inline.xs,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DSText(
                      'Subtotal',
                      customStyle: TextStyle(
                        fontSize: theme.font.size.xs,
                        color: theme.colors.neutral.dark.icon,
                      ),
                    ),
                    DSText(
                      state.price!.toCurrency(),
                      customStyle: TextStyle(
                        fontSize: theme.font.size.xs,
                        color: theme.colors.neutral.dark.icon,
                      ),
                    ),
                  ],
                ),
                if (state.shippingMethod != null) ...[
                  SizedBox(height: theme.spacing.inline.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DSText(
                        'Shipping',
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xs,
                          color: theme.colors.neutral.dark.icon,
                        ),
                      ),
                      DSText(
                        state.shippingMethod!.price.toCurrency(),
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xs,
                          color: theme.colors.neutral.dark.icon,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: theme.spacing.inline.xs),
                const ThemeDividerWidget(),
                SizedBox(height: theme.spacing.inline.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DSText(
                      'Total',
                      customStyle: TextStyle(
                        fontSize: theme.font.size.sm,
                        fontWeight: theme.font.weight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        DSIcon(
                          icon: DSIcons.tag,
                          size: DSIconSize.sm,
                          color: theme.colors.brand.secondary,
                        ),
                        SizedBox(width: theme.spacing.inline.xxs),
                        DSText(
                          state.totalPrice.toCurrency(),
                          customStyle: TextStyle(
                            fontSize: theme.font.size.sm,
                            fontWeight: theme.font.weight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
