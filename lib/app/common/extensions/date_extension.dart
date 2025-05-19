import 'package:neighborhood_market/app/core/app_consts.dart';

extension DateTimeUSFormat on DateTime {
  String toUSFormat() {
    return '${month.toString().padLeft(2, '0')}'
        '/${day.toString().padLeft(2, '0')}'
        '/$year';
  }
}

extension StringUSFormat on String {
  DateTime? toDateTimeUSFormat() {
    if (isEmpty) {
      return null;
    }

    final parts = split('/');
    if (parts.length != 3) {
      throw const FormatException('Invalid date format');
    }

    final month = int.parse(parts[0]);
    final day = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}

extension DateTimeToTime on DateTime {
  String toTime() {
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final period = hour >= 12 ? 'PM' : 'AM';
    return '${hour12.toString().padLeft(2, '0')}'
        ':${minute.toString().padLeft(2, '0')} $period CT';
  }
}

extension DateTimeToStringDate on DateTime {
  String toStringDate() {
    return '${_monthToString(month)} $day, $year';
  }

  String _monthToString(int month) {
    return AppConsts.months[month - 1];
  }
}

extension DateTimeToFull on DateTime {
  String toStringFull() {
    final dayOfWeek = AppConsts.weekdays[weekday - 1];
    final monthString = _monthToString(month);
    return '$dayOfWeek, $monthString $day, $year (GMT${timeZoneOffset.isNegative ? '-' : '+'}${timeZoneOffset.inHours.abs().toString().padLeft(2, '0')})';
  }
}
