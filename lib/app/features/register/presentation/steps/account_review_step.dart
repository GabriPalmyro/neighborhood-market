import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/pill/pill_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/list_item/list_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

class AccountReviewStep extends StatelessWidget {
  const AccountReviewStep({required this.appNavigator, super.key});
  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.inline.sm),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: theme.spacing.inline.sm),
            DSText(
              RegisterStrings.createAccount,
              customStyle: TextStyle(
                fontSize: theme.font.size.sm,
                fontWeight: theme.font.weight.semiBold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              RegisterStrings.createAccountDescription,
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.regular,
              ),
            ),
            SizedBox(height: theme.spacing.inline.sm),
            const ListItemWidget(
              leading: PillWidget(
                label: '1',
                size: DSPillSize.md,
              ),
              title: 'We are verifying your phone number',
              subtitle: 'We’re confirming your information to ensure everything is correct.',
            ),
            SizedBox(height: theme.spacing.inline.xs),
            const ListItemWidget(
              leading: PillWidget(
                label: '2',
                size: DSPillSize.md,
              ),
              title: 'Stay Tuned!',
              subtitle: 'Keep an eye on your inbox, and you’ll receive an update soon.',
            ),
            SizedBox(height: theme.spacing.inline.md),
            DSButton(
              label: RegisterStrings.backButton,
              onPressed: () {
                appNavigator.pop();
              },
              size: DSButtonSize.md,
            ),
            SizedBox(height: theme.spacing.inline.sm),
          ],
        ),
      ),
    );
  }
}
