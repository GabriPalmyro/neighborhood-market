import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/manage_cards/utils/manage_cards_strings.dart';

class BillingInformationsWidget extends StatelessWidget {
  const BillingInformationsWidget({
    required this.renewDate,
    required this.price,
    super.key,
  });

  final String renewDate;
  final String price;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.neutral.light.pure,
        borderRadius: BorderRadius.circular(
          theme.borders.radius.medium,
        ),
        border: Border.all(
          color: theme.colors.neutral.light.three,
          width: theme.borderWidth.thin,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.inline.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSText(
              ManageCardStrings.billingInformation,
              customStyle: TextStyle(
                fontSize: theme.font.size.xs,
                fontWeight: theme.font.weight.medium,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: theme.font.family.base,
                  fontSize: theme.font.size.xxs,
                  color: theme.colors.neutral.dark.icon,
                ),
                children: [
                  const TextSpan(
                    text: 'Your subscription will automatically renew on ',
                  ),
                  TextSpan(
                    text: renewDate,
                    style: TextStyle(
                      color: theme.colors.neutral.dark.pure,
                    ),
                  ),
                  const TextSpan(
                    text: ', and you will be charged ',
                  ),
                  TextSpan(
                    text: price,
                    style: TextStyle(
                      color: theme.colors.neutral.dark.pure,
                    ),
                  ),
                  const TextSpan(
                    text: ' for the monthly membership.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
