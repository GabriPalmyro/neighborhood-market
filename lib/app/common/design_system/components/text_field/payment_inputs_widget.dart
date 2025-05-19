import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text_field/payment_text_field_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/formatter/payments_formatters.dart';

class DSPaymentInputField extends StatefulWidget {
  const DSPaymentInputField({
    this.holderNameController,
    this.cardNumberController,
    this.expiryDateController,
    this.csvController,
    this.zipCodeController,
    this.enabled = true,
    this.readOnly = false,
    super.key,
  });

  final TextEditingController? holderNameController;
  final TextEditingController? cardNumberController;
  final TextEditingController? expiryDateController;
  final TextEditingController? csvController;
  final TextEditingController? zipCodeController;
  final bool enabled;
  final bool readOnly;

  @override
  State<DSPaymentInputField> createState() => _DSPaymentInputFieldState();
}

class _DSPaymentInputFieldState extends State<DSPaymentInputField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    final border = tokens.borders.radius.medium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: tokens.colors.neutral.light.pure,
            borderRadius: BorderRadius.circular(border),
            border: Border.all(
              color: tokens.colors.neutral.light.one,
              width: tokens.borderWidth.thin,
            ),
            boxShadow: [
              BoxShadow(
                color: tokens.colors.neutral.dark.three.withValues(alpha: 0.07),
                blurRadius: 4,
                spreadRadius: -1,
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          child: Column(
            children: [
              DSPaymentTextField(
                label: 'Holder Name',
                controller: widget.holderNameController,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: tokens.colors.neutral.light.one,
                      width: tokens.borderWidth.thin,
                    ),
                    bottom: BorderSide(
                      color: tokens.colors.neutral.light.one,
                      width: tokens.borderWidth.thin,
                    ),
                  ),
                ),
                child: DSPaymentTextField(
                  label: 'Card Number',
                  controller: widget.cardNumberController,
                  suffixWidget: Padding(
                    padding: EdgeInsets.only(right: tokens.spacing.inline.xxs),
                    child: const ThemeImage(
                      ThemeImages.visaCard,
                      size: Size(25, 0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [cardNumberFormatter],
                  enabled: widget.enabled,
                  readOnly: widget.readOnly,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: tokens.colors.neutral.light.one,
                            width: tokens.borderWidth.thin,
                          ),
                        ),
                      ),
                      child: DSPaymentTextField(
                        label: 'Exp Date',
                        controller: widget.expiryDateController,
                        enabled: widget.enabled,
                        readOnly: widget.readOnly,
                        keyboardType: TextInputType.number,
                        inputFormatters: [expDateFormatter],
                      ),
                    ),
                  ),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: tokens.colors.neutral.light.one,
                            width: tokens.borderWidth.thin,
                          ),
                        ),
                      ),
                      child: DSPaymentTextField(
                        label: 'CSV',
                        controller: widget.csvController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [csvFormatter],
                        enabled: widget.enabled,
                        readOnly: widget.readOnly,
                      ),
                    ),
                  ),
                  Expanded(
                    child: DSPaymentTextField(
                      label: 'Zip code',
                      controller: widget.zipCodeController,
                      enabled: widget.enabled,
                      readOnly: widget.readOnly,
                    ),
                  ),
                ],
              ),
            ],
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
