import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';

class RecoverPasswordSuccessPage extends StatelessWidget {
  const RecoverPasswordSuccessPage({
    required this.appNavigator,
    required this.email,
    super.key,
  });

  final AppNavigator appNavigator;
  final String email;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      backgroundColor: tokens.colors.neutral.light.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.inline.sm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DSText(
              'Congratulations',
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                fontSize: tokens.font.size.sm,
                fontWeight: tokens.font.weight.bold,
              ),
            ),
            SizedBox(height: tokens.spacing.inline.xs),
            DSText(
              'The password for the account associated with $email has been successfully reset.',
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                fontSize: tokens.font.size.xxs,
                fontWeight: tokens.font.weight.medium,
              ),
            ),
            SizedBox(height: tokens.spacing.inline.xs),
            DSButton(
              label: 'Continue',
              type: DSButtonType.secondary,
              size: DSButtonSize.md,
              onPressed: () {
                appNavigator.pushNamedAndRemoveUntil(Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
