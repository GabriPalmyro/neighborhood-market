import 'dart:ui';

import '../../tokens/design/colors.dart';

class BaseDSThemeColor implements DSThemeColor {
  BaseDSThemeColor({
    DSColorBrand? brand,
    DSColorFeedback? feedback,
    DSColorNeutral? neutral,
  }) {
    this.brand = brand ?? this.brand;
    this.feedback = feedback ?? this.feedback;
    this.neutral = neutral ?? this.neutral;
  }

  @override
  DSColorBrand brand = BaseColorBrand();

  @override
  DSColorFeedback feedback = BaseColorFeedback();

  @override
  DSColorNeutral neutral = BaseColorNeutral();
}

class BaseColorBrand implements DSColorBrand {
  BaseColorBrand({
    Color? primary,
    Color? secondary,
  }) {
    this.primary = primary ?? this.primary;
    this.secondary = secondary ?? this.secondary;
  }

  @override
  Color primary = const Color(0xFF000000);

  @override
  Color secondary = const Color(0xFF0058DC);
}

class BaseColorFeedback implements DSColorFeedback {
  BaseColorFeedback({
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
  }) {
    this.success = success ?? this.success;
    this.info = info ?? this.info;
    this.warning = warning ?? this.warning;
    this.error = error ?? this.error;
  }

  @override
  Color success = const Color(0xFF45B171);

  @override
  Color info = const Color(0xFFEC980C);

  @override
  Color warning = const Color(0xFFEC980C);

  @override
  Color error = const Color(0xFFDF2121);
}

class BaseColorNeutral implements DSColorNeutral {
  BaseColorNeutral({
    DSColorNeutralRange? light,
    DSColorNeutralRange? dark,
  }) {
    this.light = light ?? this.light;
    this.dark = dark ?? this.dark;
  }

  @override
  DSColorNeutralRange light = BaseColorNeutralLight();

  @override
  DSColorNeutralRange dark = BaseColorNeutralDark();
}

class BaseColorNeutralLight implements DSColorNeutralRange {
  BaseColorNeutralLight({
    Color? one,
    Color? two,
    Color? three,
    Color? pure,
    Color? icon,
    Color? background,
  }) {
    this.one = one ?? this.one;
    this.two = two ?? this.two;
    this.three = three ?? this.three;
    this.pure = pure ?? this.pure;
    this.icon = icon ?? this.icon;
    this.background = background ?? this.background;
  }

  @override
  Color one = const Color(0xFFE5E5E5);

  @override
  Color two = const Color(0xFFCCCCCC);

  @override
  Color three = const Color(0xFFE6E6E6);

  @override
  Color pure = const Color(0xFFFFFFFF);

  @override
  Color icon = const Color(0xFF7F7D83);

  @override
  Color background = const Color(0xFFF2F2F3);
}

class BaseColorNeutralDark implements DSColorNeutralRange {
  BaseColorNeutralDark({
    Color? one,
    Color? two,
    Color? three,
    Color? pure,
    Color? icon,
    Color? background,
  }) {
    this.one = one ?? this.one;
    this.two = two ?? this.two;
    this.three = three ?? this.three;
    this.pure = pure ?? this.pure;
    this.icon = icon ?? this.icon;
    this.background = background ?? this.background;
  }

  @override
  Color one = const Color(0xFF333333);

  @override
  Color two = const Color(0xFF4F4F4F);

  @override
  Color three = const Color(0xFF0A090B);

  @override
  Color pure = const Color(0xFF000000);

  @override
  Color icon = const Color(0xFF7F7D83);

  @override
  Color background = const Color(0xFF333333);
}
