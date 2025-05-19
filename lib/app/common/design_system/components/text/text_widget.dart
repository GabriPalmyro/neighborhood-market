import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class DSText extends StatelessWidget {
  const DSText(
    this.label, {
    this.customStyle,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.overflow,
    super.key,
  });
  final String label;
  final TextStyle? customStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);

    final style = TextStyle(
      color: theme.colors.neutral.dark.pure,
      fontSize: theme.font.size.xs,
      fontWeight: theme.font.weight.regular,
      fontFamily: theme.font.family.base,
    ).merge(customStyle);

    return Text(
      label,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
