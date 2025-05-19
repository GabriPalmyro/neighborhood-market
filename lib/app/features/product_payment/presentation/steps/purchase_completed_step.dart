import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/feedback/success_feedback_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_props.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/date_extension.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/purchase/purchase_cubit.dart';

class PurchaseCompletedStep extends StatelessWidget {
  const PurchaseCompletedStep({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<PurchaseCubit, PurchaseState>(
      builder: (context, state) {
        state as PaymentConfirmed;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.xs,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: theme.spacing.inline.sm),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing.inline.xs,
                  ),
                  child: const SuccessFeedbackWidget(
                    title: 'Thanks for your order!',
                    subtitle: 'The order confirmation has been sent to your email address.',
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xs),
                DSText(
                  'Your Order',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xs,
                    fontWeight: theme.font.weight.semiBold,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxs),
                ProductItemWidget(
                  props: ProductItemProps(
                    title: state.product?.title ?? '',
                    badges: state.product?.tags ?? [],
                    imageUrl: state.product?.image ?? '',
                    price: state.product?.price,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.sm),
                const ThemeDividerWidget(),
                SizedBox(height: theme.spacing.inline.xs),
                DSText(
                  'Transaction Data',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xs,
                    fontWeight: theme.font.weight.semiBold,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxxs),
                DSText(
                  DateTime.now().toStringFull(),
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xs,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xs),
                const ThemeDividerWidget(),
                SizedBox(height: theme.spacing.inline.xs),
                DSText(
                  'Payment Method',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xs,
                    fontWeight: theme.font.weight.semiBold,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxxs),
                DSText(
                  state.paymentMethod,
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xs,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxs),
                const ThemeDividerWidget(),
                SizedBox(height: theme.spacing.inline.xs),
                if (state.delivery != null) ...[
                  DSText(
                    'Delivery',
                    customStyle: TextStyle(
                      fontSize: theme.font.size.xs,
                      fontWeight: theme.font.weight.semiBold,
                    ),
                  ),
                  SizedBox(height: theme.spacing.inline.xxxs),
                  DSText(
                    state.delivery!.deliveryTime,
                    customStyle: TextStyle(
                      fontSize: theme.font.size.xs,
                    ),
                  ),
                  SizedBox(height: theme.spacing.inline.xxs),
                  const ThemeDividerWidget(),
                ],
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
                SizedBox(height: theme.spacing.inline.sm),
                DSButton(
                  label: 'Continue shopping',
                  size: DSButtonSize.md,
                  onPressed: () {
                    context.read<PurchaseCubit>().updateProductList();
                    GetIt.I.get<AppNavigator>().pushNamedAndRemoveUntil(Routes.main);
                  },
                ),
                SizedBox(
                  height: theme.spacing.inline.sm + MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
