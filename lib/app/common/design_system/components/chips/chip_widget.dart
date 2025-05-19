// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    required this.label,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return ClickableWidget(
      borderRadius: BorderRadius.circular(theme.borders.radius.pill),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.brand.secondary.withValues(alpha: 0.25) : theme.colors.neutral.light.pure,
          border: Border.all(
            color: isSelected ? theme.colors.brand.secondary : theme.colors.neutral.light.one,
            width: theme.borderWidth.thin,
          ),
          borderRadius: BorderRadius.circular(
            theme.borders.radius.pill,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colors.neutral.light.one.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: theme.spacing.inline.xxxs + 2,
            horizontal: theme.spacing.inline.xs,
          ),
          child: DSText(
            label,
            customStyle: TextStyle(
              color: isSelected ? theme.colors.brand.secondary : theme.colors.neutral.dark.three,
              fontSize: theme.font.size.xxs,
              fontWeight: theme.font.weight.medium,
            ),
          ),
        ),
      ),
    );
  }
}
