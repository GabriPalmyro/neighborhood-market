import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriceInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 2,
  );

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove any non-digit characters
    final String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Parse to a double and divide by 100 to get cents
    final double value = double.parse(digitsOnly) / 100;

    // Format to currency
    final String formattedText = _currencyFormat.format(value);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

extension PriceParsing on String {
  double parseToDouble() {
    final String formattedPrice = trim();
    if (formattedPrice.isEmpty) {
      return 0.0;
    }

    final String digitsOnly = formattedPrice.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(digitsOnly) ?? 0.0;
  }
}
