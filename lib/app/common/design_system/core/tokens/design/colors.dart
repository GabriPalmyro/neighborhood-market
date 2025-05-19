import 'package:flutter/material.dart';

class DSThemeColor {
  DSThemeColor({
    required this.brand,
    required this.feedback,
    required this.neutral,
  });

  DSColorBrand brand;
  DSColorFeedback feedback;
  DSColorNeutral neutral;
}

abstract class DSColorBrand {
  DSColorBrand({
    required this.primary,
    required this.secondary,
  });

  Color primary;
  Color secondary;
}

abstract class DSColorFeedback {
  DSColorFeedback({
    required this.success,
    required this.info,
    required this.warning,
    required this.error,
  });

  Color success;
  Color info;
  Color warning;
  Color error;
}

abstract class DSColorNeutral {
  DSColorNeutral({
    required this.light,
    required this.dark,
  });

  DSColorNeutralRange light;
  DSColorNeutralRange dark;
}

abstract class DSColorNeutralRange {
  DSColorNeutralRange({
    required this.one,
    required this.two,
    required this.three,
    required this.pure,
    required this.icon,
    required this.background,
  });

  Color one;
  Color two;
  Color three;
  Color pure;
  Color icon;
  Color background;
}
