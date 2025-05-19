import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    required this.finalDigits,
    super.key,
  });

  final String finalDigits;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    const height = 45.0;
    return Container(
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
        children: [
          const ThemeImage(
            ThemeImages.visaCard,
            size: Size(30, 30),
          ),
          const SizedBox(width: 8),
          Text(
            '**** **** **** $finalDigits',
            style: TextStyle(
              color: theme.colors.neutral.dark.three,
              fontSize: theme.font.size.xs,
              fontWeight: theme.font.weight.medium,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: theme.colors.neutral.dark.icon,
            size: theme.font.size.xxs,
          ),
        ],
      ),
    );
  }
}
