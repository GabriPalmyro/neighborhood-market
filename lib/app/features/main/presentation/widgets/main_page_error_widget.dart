import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/core/app_strings.dart';

class MainPageErrorWidget extends StatelessWidget {
  const MainPageErrorWidget({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          SizedBox(height: theme.spacing.inline.xxs),
          DSText(
            AppStrings.errorTitle,
            customStyle: TextStyle(
              color: theme.colors.neutral.dark.pure,
              fontSize: theme.font.size.md,
              fontWeight: theme.font.weight.bold,
            ),
          ),
          SizedBox(height: theme.spacing.inline.xxxs),
          DSText(
            AppStrings.errorSubtitle,
            customStyle: TextStyle(
              color: theme.colors.neutral.dark.pure,
              fontSize: theme.font.size.xs,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: DSButton(
              label: AppStrings.errorButtonLabel,
              type: DSButtonType.secondary,
              onPressed: () => onRetry(),
            ),
          ),
          SizedBox(height: theme.spacing.inline.md),
        ],
      ),
    );
  }
}
