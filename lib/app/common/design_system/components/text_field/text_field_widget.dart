import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class DSTextField extends StatefulWidget {
  const DSTextField({
    required this.label,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText = false,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.prefixWidget,
    this.suffixWidget,
    this.autovalidateMode,
    this.hintText = '',
    this.enabled = true,
    this.readOnly = false,
    this.autocorrect = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.onTapOutside,
    this.onTap,
    this.autofillHints,
    this.expandable = false,
    this.textCapitalization,
    super.key,
  });

  final String label;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final AutovalidateMode? autovalidateMode;
  final String hintText;
  final bool enabled;
  final bool readOnly;
  final bool autocorrect;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final bool expandable;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onTap;
  final List<String>? autofillHints;
  final TextCapitalization? textCapitalization;

  @override
  State<DSTextField> createState() => _DSTextFieldState();
}

class _DSTextFieldState extends State<DSTextField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    final height = widget.expandable == false ? null : 140.0;
    final border = widget.expandable == false ? tokens.borders.radius.pill : tokens.borders.radius.extraLarge;
    final borderWidth = tokens.borderWidth.thin;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(border),
            boxShadow: [
              BoxShadow(
                color: tokens.colors.neutral.dark.three.withValues(alpha: 0.07),
                blurRadius: 4,
                spreadRadius: -1,
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.obscureText,
            autofillHints: widget.autofillHints,
            obscuringCharacter: '*',
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onFieldSubmitted,
            textAlignVertical: widget.expandable ? TextAlignVertical.top : TextAlignVertical.center,
            textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
            validator: (value) {
              final String? errorText = widget.validator?.call(value);

              setState(() {
                _errorText = errorText;
              });

              return errorText;
            },
            onChanged: (value) {
              widget.onChanged?.call(value);
            },
            onTap: widget.onTap,
            style: TextStyle(
              color: tokens.colors.neutral.dark.pure,
              fontSize: tokens.font.size.xxs,
              fontWeight: tokens.font.weight.regular,
              fontFamily: tokens.font.family.base,
            ).copyWith(
              color: widget.enabled
                ? tokens.colors.neutral.dark.pure 
                : tokens.colors.neutral.light.icon,
            ),
            cursorWidth: tokens.borderWidth.thin,
            cursorColor: tokens.colors.neutral.dark.one,
            decoration: InputDecoration(
              prefixIcon: widget.prefixWidget,
              suffixIcon: widget.suffixWidget,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.inline.xs,
                vertical: widget.expandable ? tokens.spacing.inline.xs : tokens.spacing.inline.xxs,
              ),
              hintText: widget.label,
              hintStyle: TextStyle(
                color: tokens.colors.neutral.light.two,
                fontSize: tokens.font.size.xxs,
                fontWeight: tokens.font.weight.regular,
              ),
              fillColor: tokens.colors.neutral.light.pure,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  border,
                ),
                borderSide: BorderSide(
                  color: tokens.colors.neutral.light.three,
                  width: borderWidth,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  border,
                ),
                borderSide: BorderSide(
                  color: tokens.colors.neutral.light.three,
                  width: borderWidth,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  border,
                ),
                borderSide: BorderSide(
                  color: tokens.colors.neutral.light.three,
                  width: borderWidth,
                ),
              ),
              errorStyle: const TextStyle(fontSize: 0),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  border,
                ),
                borderSide: BorderSide(
                  color: tokens.colors.feedback.error,
                  width: borderWidth,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  border,
                ),
                borderSide: BorderSide(
                  color: tokens.colors.feedback.error,
                  width: borderWidth,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  border,
                ),
                borderSide: BorderSide(
                  color: tokens.colors.neutral.light.three,
                  width: borderWidth,
                ),
              ),
            ),
            autovalidateMode: widget.autovalidateMode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            autocorrect: widget.autocorrect,
            autofocus: widget.autofocus,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            expands: widget.expandable,
            onTapOutside: widget.onTapOutside,
          ),
        ),
        if (_errorText?.isNotEmpty == true) ...[
          Padding(
            padding: EdgeInsets.only(left: tokens.spacing.inline.xxs, top: 3.0),
            child: DSText(
              _errorText!,
              customStyle: TextStyle(
                color: tokens.colors.feedback.error,
                fontSize: tokens.font.size.xxxs,
                fontWeight: tokens.font.weight.extraLight,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
