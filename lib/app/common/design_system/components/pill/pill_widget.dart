import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

enum DSPillSize { sm, md, lg }

class PillWidget extends StatelessWidget {
  const PillWidget({
    required this.label,
    this.size = DSPillSize.sm,
    this.backgroundColor,
    this.textColor,
    super.key,
  });

  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final DSPillSize size;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Container(
      height: size == DSPillSize.sm
          ? theme.spacing.inline.xs * 2
          : size == DSPillSize.md
              ? theme.spacing.inline.sm * 2
              : theme.spacing.inline.md * 2,
      width: size == DSPillSize.sm
          ? theme.spacing.inline.xs * 2
          : size == DSPillSize.md
              ? theme.spacing.inline.sm * 2
              : theme.spacing.inline.md * 2,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.neutral.light.pure,
        borderRadius: BorderRadius.circular(theme.borders.radius.circular),
        border: Border.fromBorderSide(
          BorderSide(
            color: theme.colors.neutral.light.three,
            width: theme.borderWidth.thick,
          ),
        ),
      ),
      child: Center(
        child: DSText(
          label,
          customStyle: TextStyle(
            color: textColor ?? theme.colors.neutral.dark.one,
            fontSize: size == DSPillSize.sm
                ? theme.font.size.xxs
                : size == DSPillSize.md
                    ? theme.font.size.xs
                    : theme.font.size.sm,
            fontWeight: theme.font.weight.semiBold,
          ),
        ),
      ),
    );
  }
}
