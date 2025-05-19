import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class ThemeCardWidget extends StatelessWidget {
  const ThemeCardWidget({
    required this.borderRadius,
    required this.child,
    super.key,
  });

  final BorderRadius borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.colors.neutral.light.three,
        borderRadius: borderRadius,
        border: Border.all(
          color: tokens.colors.neutral.light.one,
          width: tokens.borderWidth.thin,
        ),
      ),
      child: child,
    );
  }
}
