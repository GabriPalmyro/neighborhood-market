import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    required this.title,
    this.leading,
    this.trailing,
    this.subtitle,
    this.isCentered = false,
    super.key,
  });

  final Widget? leading;
  final Widget? trailing;
  final String title;
  final String? subtitle;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        leading ?? const SizedBox(),
        SizedBox(width: theme.spacing.inline.xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DSText(
                title,
                customStyle: TextStyle(
                  fontSize: theme.font.size.xs,
                  fontWeight: theme.font.weight.semiBold,
                ),
              ),
              if (subtitle?.isNotEmpty == true) ...[
                SizedBox(height: theme.spacing.inline.xxxs),
                DSText(
                  subtitle!,
                  customStyle: TextStyle(
                    color: theme.colors.neutral.dark.one,
                    fontSize: theme.font.size.xxxs,
                    fontWeight: theme.font.weight.regular,
                  ),
                ),
              ],
            ],
          ),
        ),
        trailing ?? const SizedBox(),
      ],
    );
  }
}
