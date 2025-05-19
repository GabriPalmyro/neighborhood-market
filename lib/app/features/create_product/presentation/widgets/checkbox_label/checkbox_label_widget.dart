import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class CheckboxLabelWidget extends StatelessWidget {
  const CheckboxLabelWidget({
    required this.label,
    required this.onTap,
    this.isChecked = false,
    this.tooltip,
    super.key,
  });
  final String label;
  final String? tooltip;
  final bool isChecked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.inline.xxs,
          ),
          child: Tooltip(
            message: tooltip ?? '',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DSText(
                  label,
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    fontWeight: theme.font.weight.medium,
                  ),
                ),
                if (tooltip != null) ...[
                  SizedBox(width: theme.spacing.inline.xxxs),
                  const Icon(
                    Icons.info_outline,
                    size: 14,
                  ),
                ],
              ],
            ),
          ),
        ),
        ClickableWidget(
          onTap: onTap,
          borderRadius: BorderRadius.circular(theme.borders.radius.medium),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: theme.spacing.inline.xxxs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  isError: false,
                  value: isChecked,
                  side: BorderSide(
                    color: theme.colors.neutral.dark.two,
                    width: theme.borderWidth.thin,
                  ),
                  activeColor: theme.colors.brand.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                    side: BorderSide(
                      color: theme.colors.neutral.light.three,
                    ),
                  ),
                  onChanged: (_) {
                    onTap.call();
                  },
                ),
                Expanded(
                  child: DSText(
                    tooltip ?? '',
                    customStyle: TextStyle(
                      color: theme.colors.neutral.dark.three,
                      fontSize: theme.font.size.xxs,
                      fontWeight: theme.font.weight.regular,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
