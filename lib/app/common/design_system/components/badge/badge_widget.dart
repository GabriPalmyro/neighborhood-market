import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

enum BadgeSize {
  small,
  medium,
}

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    required this.label,
    this.size = BadgeSize.small,
    super.key,
  });

  final String label;
  final BadgeSize size;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    final fontSize = size == BadgeSize.small ? tokens.font.size.xxxs : tokens.font.size.xs;
    return Container(
      decoration: BoxDecoration(
        color: tokens.colors.brand.secondary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 2,
      ),
      child: DSText(
        label,
        customStyle: TextStyle(
          color: tokens.colors.brand.secondary,
          fontSize: fontSize,
          fontWeight: tokens.font.weight.medium,
        ),
      ),
    );
  }
}

class SelectBadgeWidget extends StatelessWidget {
  const SelectBadgeWidget({
    required this.label,
    required this.size,
    required this.isSelected,
    this.onTap,
    super.key,
  });

  final String label;
  final BadgeSize size;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? tokens.colors.brand.primary : tokens.colors.neutral.light.pure,
          borderRadius: BorderRadius.circular(tokens.borders.radius.circular),
          border: isSelected
              ? null
              : Border.all(
                  color: tokens.colors.neutral.light.three,
                  width: tokens.borderWidth.thin,
                ),
        ),
        child: ClickableWidget(
          onTap: onTap,
          borderRadius: BorderRadius.circular(tokens.borders.radius.circular),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.inline.xs,
              vertical: tokens.spacing.inline.xxxs,
            ),
            child: DSText(
              label,
              customStyle: TextStyle(
                color: isSelected ? tokens.colors.neutral.light.pure : tokens.colors.neutral.dark.icon,
                fontSize: tokens.font.size.xxxs,
                fontWeight: tokens.font.weight.medium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
