import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class SelectImageInputBottomSheet extends StatelessWidget {
  const SelectImageInputBottomSheet({
    required this.onGallerySelected,
    required this.onPictureSelected,
    super.key,
  });

  final VoidCallback onGallerySelected;
  final VoidCallback onPictureSelected;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        theme.spacing.inline.xs,
        theme.spacing.inline.sm,
        theme.spacing.inline.xs,
        theme.spacing.inline.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DSButton(
            label: 'Take a Photo',
            type: DSButtonType.primaryOutline,
            onPressed: onPictureSelected,
          ),
          SizedBox(height: theme.spacing.inline.xs),
          DSButton(
            label: 'Select from Gallery',
            onPressed: onGallerySelected,
          ),
          SizedBox(height: theme.spacing.inline.sm),
        ],
      ),
    );
  }
}
