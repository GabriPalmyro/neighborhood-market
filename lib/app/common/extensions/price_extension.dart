import 'package:intl/intl.dart';

extension PriceExtension on double {
  String toCurrency() {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    ).format(this);
  }

  String toCurrencyWithoutSymbol() {
    return NumberFormat.currency(
      symbol: '',
      locale: 'en_US',
      decimalDigits: 2,
    ).format(this);
  }
}
