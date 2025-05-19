import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class DSDropdownWidget extends StatelessWidget {
  const DSDropdownWidget({
    required this.hintText,
    this.label,
    this.enabled = true,
    this.onTap,
    super.key,
  });

  final String? label;
  final VoidCallback? onTap;
  final String hintText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    final border = theme.borders.radius.pill;
    final borderWidth = theme.borderWidth.thin;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: theme.spacing.inline.xxs,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            border,
          ),
          border: Border.all(
            color: enabled ? theme.colors.neutral.light.three : theme.colors.neutral.light.one,
            width: borderWidth,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.inline.xs,
              ),
              child: Text(
                label ?? hintText,
                style: TextStyle(
                  fontSize: theme.font.size.xs,
                  color: label != null 
                    ? theme.colors.neutral.dark.one 
                    : theme.colors.neutral.light.two,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.inline.xs,
              ),
              child: DSIcon(
                icon: DSIcons.chevronDown,
                size: DSIconSize.md,
                color: theme.colors.neutral.dark.one,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
