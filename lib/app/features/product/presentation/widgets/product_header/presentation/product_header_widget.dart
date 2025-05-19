import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class ProductHeaderWidget extends StatelessWidget {
  const ProductHeaderWidget({
    required this.label,
    required this.price,
    super.key,
  });

  final String label;
  final String price;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText(
          label,
          customStyle: TextStyle(
            fontSize: theme.font.size.xs,
            fontWeight: theme.font.weight.bold,
          ),
        ),
         SizedBox(height: theme.spacing.inline.xxxs),
        DSText(
          price,
          customStyle: TextStyle(
            fontSize: theme.font.size.xs,
            fontWeight: theme.font.weight.bold,
          ),
        ),
      ],
    );
  }
}
