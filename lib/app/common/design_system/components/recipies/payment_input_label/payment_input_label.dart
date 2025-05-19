import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text_field/payment_inputs_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class PaymentInputLabel extends StatelessWidget {
  const PaymentInputLabel({
    required this.label,
    this.tooltip,
    this.readOnly = false,
    super.key,
  });

  final String label;
  final String? tooltip;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
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
        DSPaymentInputField(
          readOnly: readOnly,
        ),
      ],
    );
  }
}
