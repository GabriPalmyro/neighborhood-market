import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/list_item/list_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/core/app_strings.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/product_order/product_payment_order_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/shipping_methods/shipping_methods_cubit.dart';

class SelectShippingMethodWidget extends StatelessWidget {
  const SelectShippingMethodWidget({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText(
          'Delivery',
          customStyle: TextStyle(
            fontSize: theme.font.size.xs,
            fontWeight: theme.font.weight.semiBold,
          ),
        ),
        BlocBuilder<ProductPaymentOrderCubit, ProductPaymentOrderState>(
          builder: (context, state) {
            state as ProductPaymentOrderLoaded;
            final shippingMethodSelected = state.shippingMethod;

            return BlocBuilder<ShippingMethodsCubit, ShippingMethodsState>(
              builder: (context, state) {
                if (state is ShippingMethodsLoading) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      2,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: theme.spacing.inline.xs,
                          ),
                          child: const ShimmerComponent(
                            width: double.infinity,
                            height: 45,
                          ),
                        );
                      },
                    ).toList(),
                  );
                }

                if (state is ShippingMethodsFailure) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DSText(
                        AppStrings.errorTitle,
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xs,
                          fontWeight: theme.font.weight.semiBold,
                        ),
                      ),
                      DSText(
                        AppStrings.errorSubtitle,
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xxxs,
                        ),
                      ),
                      SizedBox(height: theme.spacing.inline.xxs),
                      SizedBox(
                        width: double.infinity,
                        child: DSButton(
                          label: AppStrings.errorButtonLabel,
                          type: DSButtonType.secondary,
                          size: DSButtonSize.sm,
                          onPressed: () {
                            context.read<ShippingMethodsCubit>().getShippingMethods();
                          },
                        ),
                      ),
                    ],
                  );
                }

                final shippingMethods = (state as ShippingMethodsLoaded).shippingMethods;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: shippingMethods.map(
                    (shippingMethod) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: theme.spacing.inline.xs,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context.read<ProductPaymentOrderCubit>().setShippingMethod(shippingMethod);

                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                          child: ListItemWidget(
                            leading: SizedBox(
                              width: 20,
                              child: Radio(
                                value: shippingMethod,
                                groupValue: shippingMethodSelected,
                                onChanged: null,
                              ),
                            ),
                            title: '${shippingMethod.name} (Shipping ${shippingMethod.price.toCurrency()})',
                            subtitle: shippingMethod.deliveryTime,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
