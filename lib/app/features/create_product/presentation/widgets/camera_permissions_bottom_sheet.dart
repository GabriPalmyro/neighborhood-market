import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermissionsBottomSheet extends StatelessWidget {
  const CameraPermissionsBottomSheet({super.key});

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
              'Camera Permission is Required',
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.pure,
                fontSize: theme.font.size.md,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              'Please allow camera permissions to take a picture of the item. You can change this in the settings.',
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.pure,
                fontSize: theme.font.size.xs,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            DSButton(
              label: 'Go to Settings',
              type: DSButtonType.secondary,
              onPressed: () {
                openAppSettings();
              },
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
