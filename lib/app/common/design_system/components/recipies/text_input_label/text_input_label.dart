import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text_field/text_field_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class TextInputLabelWidget extends StatelessWidget {
  const TextInputLabelWidget({
    required this.label,
    required this.hintText,
    this.tooltip,
    this.controller,
    this.prefixWidget,
    this.suffixWidget,
    this.keyboardType,
    this.formatter,
    this.focusNode,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.onSubmitted,
    this.textInputAction,
    this.onChanged,
    this.autofillHints,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.sentences,
    super.key,
  });

  final String label;
  final String? tooltip;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final TextInputFormatter? formatter;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool readOnly;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final List<String>? autofillHints;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool enabled;
  final TextCapitalization textCapitalization;

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
        DSTextField(
          controller: controller,
          validator: validator,
          label: hintText,
          prefixWidget: prefixWidget,
          suffixWidget: suffixWidget,
          obscureText: obscureText,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onFieldSubmitted: onSubmitted,
          inputFormatters: formatter != null ? [formatter!] : null,
          onTap: onTap,
          onChanged: onChanged,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          maxLines: maxLines,
          minLines: minLines,
          expandable: expands,
          focusNode: focusNode,
          enabled: enabled,
          textCapitalization: textCapitalization,
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }
}
