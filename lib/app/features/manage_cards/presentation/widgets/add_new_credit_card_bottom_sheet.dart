import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/payment_input_label/payment_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/manage_cards/utils/manage_cards_strings.dart';

class AddNewCreditCardBottomSheet extends StatelessWidget {
  const AddNewCreditCardBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        theme.spacing.inline.xs,
        theme.spacing.inline.xs,
        theme.spacing.inline.xs,
        MediaQuery.of(context).viewInsets.bottom + theme.spacing.inline.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: theme.spacing.inline.xxs),
          const PaymentInputLabel(
            label: ManageCardStrings.paymentLabel,
            tooltip: 'Payment method',
          ),
          SizedBox(height: theme.spacing.inline.sm),
          DSButton(
            label: 'Add card',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
