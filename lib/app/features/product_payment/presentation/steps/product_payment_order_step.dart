import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_props.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/payment_step/product_payment_steps_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/product_order/product_payment_order_cubit.dart';

class ProductPaymentOrderStep extends StatelessWidget {
  const ProductPaymentOrderStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    const double shimmerHeight = 126.0;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.inline.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: theme.spacing.inline.sm),
          DSText(
            'Your Order',
            customStyle: TextStyle(
              fontSize: theme.font.size.xs,
              fontWeight: theme.font.weight.semiBold,
            ),
          ),
          SizedBox(height: theme.spacing.inline.xxs),
          BlocConsumer<ProductPaymentOrderCubit, ProductPaymentOrderState>(
            listener: (context, state) {
              if (state is ProductPaymentOrderError) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showErrorSnackBar(
                  context,
                  content: 'An error occurred while loading the product. Please try again later.',
                );
              }
            },
            builder: (context, state) {
              return FadeSwitcher(
                child: () {
                  if (state is ProductPaymentOrderLoaded) {
                    return ProductItemWidget(
                      props: ProductItemProps(
                        title: state.entity.title ?? '',
                        badges: state.entity.tags,
                        imageUrl: state.entity.image ?? '',
                        price: state.entity.price ?? 0.0,
                      ),
                    );
                  }

                  return const ShimmerComponent(
                    width: double.infinity,
                    height: shimmerHeight,
                  );
                }(),
              );
            },
          ),
          SizedBox(height: theme.spacing.inline.xs),
          BlocBuilder<ProductPaymentOrderCubit, ProductPaymentOrderState>(
            builder: (context, state) {
              return Row(
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
                      if (state is ProductPaymentOrderLoaded) ...[
                        DSText(
                          (state.price ?? 0.0).toCurrency(),
                          customStyle: TextStyle(
                            fontSize: theme.font.size.sm,
                            fontWeight: theme.font.weight.bold,
                          ),
                        ),
                      ] else ...[
                        const ShimmerComponent(width: 40, height: 20),
                      ],
                    ],
                  ),
                ],
              );
            },
          ),
          const Spacer(),
          BlocBuilder<ProductPaymentOrderCubit, ProductPaymentOrderState>(
            builder: (context, state) {
              return DSButton(
                type: state is ProductPaymentOrderLoaded ? DSButtonType.primary : DSButtonType.ghost,
                label: 'Continue',
                size: DSButtonSize.md,
                onPressed: () {
                  if (state is ProductPaymentOrderLoaded) {
                    context.read<ProductPaymentStepsCubit>().nextStep();
                  }
                },
              );
            },
          ),
          SizedBox(
            height: theme.spacing.inline.sm + MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
