import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class SaveProfileButtonWidget extends StatelessWidget {
  const SaveProfileButtonWidget({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Container(
      color: theme.colors.neutral.light.pure,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: theme.spacing.inline.xxs,
        bottom: theme.spacing.inline.xs + (Platform.isIOS ? MediaQuery.of(context).padding.bottom : 0),
        left: theme.spacing.inline.xs,
        right: theme.spacing.inline.xs,
      ),
      child: DSButton(
        label: 'Save Profile',
        type: DSButtonType.secondary,
        onPressed: onPressed,
      ),
    );
  }
}
