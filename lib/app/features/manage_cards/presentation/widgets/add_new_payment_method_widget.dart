import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/manage_cards/presentation/widgets/add_new_credit_card_bottom_sheet.dart';

class AddNewPaymentMethodWidget extends StatelessWidget {
  const AddNewPaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    const height = 45.0;
    return ClickableWidget(
      onTap: () {
        showDSBottomSheet(
          context: context,
          isScrollControlled: true,
          child: const AddNewCreditCardBottomSheet(),
        );
      },
      borderRadius: BorderRadius.circular(theme.borders.radius.pill),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: theme.colors.neutral.light.pure,
          borderRadius: BorderRadius.circular(theme.borders.radius.pill),
          border: Border.all(
            color: theme.colors.neutral.light.three,
            width: theme.borderWidth.thin,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.inline.xs,
          vertical: theme.spacing.inline.xxxs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline_rounded,
              size: theme.font.size.sm,
              color: theme.colors.neutral.dark.two,
            ),
            SizedBox(width: theme.spacing.inline.xxs),
            DSText(
              'Change a payment method',
              customStyle: TextStyle(
                fontSize: theme.font.size.xs,
                color: theme.colors.neutral.dark.two,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
