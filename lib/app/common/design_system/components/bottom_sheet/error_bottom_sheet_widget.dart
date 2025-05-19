import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/core/app_strings.dart';

class ErrorBottomSheetWidget extends StatelessWidget {
  const ErrorBottomSheetWidget({
    required this.message,
    this.onTap,
    super.key,
  });

  final String message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.inline.xs,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: theme.spacing.inline.sm),
            Icon(
              Icons.error_outline,
              color: theme.colors.feedback.error,
              size: 60,
            ),
            SizedBox(height: theme.spacing.inline.xs),
            DSText(
              AppStrings.errorTitle,
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.pure,
                fontSize: theme.font.size.md,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              message,
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.pure,
                fontSize: theme.font.size.xs,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            SizedBox(
              width: double.infinity,
              child: DSButton(
                label: AppStrings.errorCloseButtonLabel,
                type: DSButtonType.secondary,
                onPressed: onTap ??
                    () {
                      Navigator.of(context).pop();
                    },
              ),
            ),
            SizedBox(
              height: theme.spacing.inline.md + MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
