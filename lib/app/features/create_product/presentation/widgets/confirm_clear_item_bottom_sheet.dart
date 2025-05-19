import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class ConfirmClearItemBottomSheet extends StatelessWidget {
  const ConfirmClearItemBottomSheet({
    this.onTap,
    super.key,
  });

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: theme.spacing.inline.sm),
            DSText(
              'Clear all listing information?',
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.pure,
                fontSize: theme.font.size.md,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              'If you clear the information, you will lose all the information you have entered.',
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.pure,
                fontSize: theme.font.size.xs,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            Row(
              children: [
                Expanded(
                  child: DSButton(
                    label: 'Cancel',
                    type: DSButtonType.ghost,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(width: theme.spacing.inline.xs),
                Expanded(
                  child: DSButton(
                    label: 'Confirm',
                    type: DSButtonType.secondary,
                    onPressed: onTap ??
                        () {
                          Navigator.of(context).pop();
                        },
                  ),
                ),
              ],
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
