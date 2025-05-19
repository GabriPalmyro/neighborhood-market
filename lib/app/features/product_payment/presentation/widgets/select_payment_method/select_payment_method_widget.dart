import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/list_item/list_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/product_order/product_payment_order_cubit.dart';

class SelectPaymentMethodWidget extends StatelessWidget {
  const SelectPaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<ProductPaymentOrderCubit, ProductPaymentOrderState>(
      builder: (context, state) {
        state as ProductPaymentOrderLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSText(
              'Select payment method',
              customStyle: TextStyle(
                fontSize: theme.font.size.xs,
                fontWeight: theme.font.weight.semiBold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            GestureDetector(
              onTap: () {
                context.read<ProductPaymentOrderCubit>().setPaymentMethod('venmo');
              },
              child: ListItemWidget(
                leading: SizedBox(
                  width: 20,
                  child: Radio(
                    value: 'venmo',
                    groupValue: state.paymentMethod,
                    onChanged: null,
                  ),
                ),
                title: 'Venmo',
                subtitle: 'A mobile payment service that allows quick transfers from Venmo accounts.',
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            GestureDetector(
              onTap: () {
                context.read<ProductPaymentOrderCubit>().setPaymentMethod('cashapp');
              },
              child: ListItemWidget(
                leading: SizedBox(
                  width: 20,
                  child: Radio(
                    value: 'cashapp',
                    groupValue: state.paymentMethod,
                    onChanged: null,
                  ),
                ),
                title: 'CashApp',
                subtitle: 'A mobile payment service that allows quick transfers from Venmo accounts.',
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            GestureDetector(
              onTap: () {
                context.read<ProductPaymentOrderCubit>().setPaymentMethod('zelle');
              },
              child: ListItemWidget(
                leading: SizedBox(
                  width: 20,
                  child: Radio(
                    value: 'zelle',
                    groupValue: state.paymentMethod,
                    onChanged: null,
                  ),
                ),
                title: 'Zelle',
                subtitle: 'A mobile payment service that allows fast and direct bank transfers instantly',
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            GestureDetector(
              onTap: () {
                context.read<ProductPaymentOrderCubit>().setPaymentMethod('paypal');
              },
              child: ListItemWidget(
                leading: SizedBox(
                  width: 20,
                  child: Radio(
                    value: 'paypal',
                    groupValue: state.paymentMethod,
                    onChanged: null,
                  ),
                ),
                title: 'PayPal',
                subtitle: 'A secure and widely used online payment system for transactions.',
              ),
            ),
          ],
        );
      },
    );
  }
}
