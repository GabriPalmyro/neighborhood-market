import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/chips/chip_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/create_product/utils/product_conditions.dart';

class ConditionsFilterChoiceWigdet extends StatelessWidget {
  const ConditionsFilterChoiceWigdet({
    required this.label,
    required this.onTap,
    this.selectedIds = const [],
    this.tooltip,
    super.key,
  });
  final String label;
  final String? tooltip;
  final Function(String) onTap;
  final List<String> selectedIds;

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
        SizedBox(height: theme.spacing.inline.xxs),
        Wrap(
          spacing: theme.spacing.inline.xxs,
          runSpacing: theme.spacing.inline.xxs,
          children: List.generate(
            productConditions.length,
            (index) => ChipWidget(
              isSelected: selectedIds
                  .map(
                    (e) => e.toLowerCase(),
                  )
                  .contains(
                    productConditions[index].toLowerCase(),
                  ),
              label: productConditions[index],
              onTap: () {
                onTap.call(productConditions[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
