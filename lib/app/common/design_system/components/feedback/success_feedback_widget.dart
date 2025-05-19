import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class SuccessFeedbackWidget extends StatelessWidget {
  const SuccessFeedbackWidget({
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onButtonPressed,
    super.key,
  });

  final String title;
  final String subtitle;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DSIcon(
            icon: DSIcons.check,
            size: DSIconSize.xl,
            color: theme.colors.feedback.success,
          ),
          SizedBox(height: theme.spacing.inline.xxs),
          DSText(
            title,
            textAlign: TextAlign.center,
            customStyle: TextStyle(
              fontSize: theme.font.size.sm,
              fontWeight: theme.font.weight.bold,
            ),
          ),
          SizedBox(height: theme.spacing.inline.xxxs),
          DSText(
            subtitle,
            textAlign: TextAlign.center,
            customStyle: TextStyle(
              fontSize: theme.font.size.xxs,
              color: theme.colors.neutral.dark.icon,
            ),
          ),
          if (buttonLabel != null && onButtonPressed != null) ...[
            SizedBox(height: theme.spacing.inline.xs),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: DSButton(
                label: buttonLabel!,
                onPressed: onButtonPressed!,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
