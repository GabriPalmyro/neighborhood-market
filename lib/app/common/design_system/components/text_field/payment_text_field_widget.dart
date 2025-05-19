// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class DSPaymentTextField extends StatelessWidget {
  const DSPaymentTextField({
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
    this.onTapOutside,
    this.onTap,
    this.autofillHints,
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
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onTap;
  final List<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      autofillHints: autofillHints,
      obscuringCharacter: '*',
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      style: TextStyle(
        color: tokens.colors.neutral.dark.pure,
        fontSize: tokens.font.size.xxs,
        fontWeight: tokens.font.weight.regular,
        fontFamily: tokens.font.family.base,
      ),
      cursorWidth: tokens.borderWidth.thin,
      cursorColor: tokens.colors.neutral.dark.one,
      decoration: InputDecoration(
        prefixIcon: prefixWidget,
        suffixIcon: suffixWidget,
        contentPadding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.inline.xs,
        ),
        hintText: label,
        hintStyle: TextStyle(
          color: tokens.colors.neutral.light.two,
          fontSize: tokens.font.size.xxs,
          fontWeight: tokens.font.weight.regular,
        ),
        fillColor: tokens.colors.neutral.light.pure,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(fontSize: 0),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      readOnly: readOnly,
      autocorrect: autocorrect,
      autofocus: autofocus,
      onTapOutside: onTapOutside,
    );
  }
}
