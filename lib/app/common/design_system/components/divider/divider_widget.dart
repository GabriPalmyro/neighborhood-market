import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class ThemeDividerWidget extends StatelessWidget {
  const ThemeDividerWidget({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return Divider(
      height: tokens.borderWidth.thin,
      thickness: tokens.borderWidth.thin,
      color: color ?? tokens.colors.neutral.light.two,
    );
  }
}
