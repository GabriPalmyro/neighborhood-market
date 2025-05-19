import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/create_product/utils/create_product_strings.dart';

class TermsAgreementWidget extends StatelessWidget {
  const TermsAgreementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.inline.xxs),
      child: RichText(
        text: TextSpan(
          text: CreateProductStrings.publishingPoliticsDescription,
          style: TextStyle(
            fontFamily: theme.font.family.base,
            color: theme.colors.neutral.dark.three,
            fontSize: theme.font.size.xxs,
            fontWeight: theme.font.weight.regular,
          ),
          children: [
            TextSpan(
              text: CreateProductStrings.termsOfUse,
              style: TextStyle(
                color: theme.colors.brand.secondary,
                fontWeight: theme.font.weight.medium,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // TODO(gabriel): Navigate to Terms of Use
                },
            ),
            TextSpan(
              text: CreateProductStrings.and,
              style: TextStyle(
                color: theme.colors.brand.primary,
              ),
            ),
            TextSpan(
              text: CreateProductStrings.privacyPolicy,
              style: TextStyle(
                color: theme.colors.brand.secondary,
                fontWeight: theme.font.weight.medium,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // TODO(gabriel): Navigate to Privacy Policy
                },
            ),
          ],
        ),
      ),
    );
  }
}
