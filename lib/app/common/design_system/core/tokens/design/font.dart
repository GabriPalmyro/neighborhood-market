import 'package:flutter/material.dart';

class DSThemeFont {
  DSThemeFont({
    required this.family,
    required this.weight,
    required this.size,
  });

  DSFontFamily family;
  DSFontWeight weight;
  DSFontSize size;
}

class DSFontFamily {
  DSFontFamily({required this.base});
  String base;
}

class DSFontWeight {
  DSFontWeight({
    required this.thin,
    required this.extraLight,
    required this.light,
    required this.regular,
    required this.medium,
    required this.semiBold,
    required this.bold,
    required this.extraBold,
    required this.black,
  });

  FontWeight thin;
  FontWeight extraLight;
  FontWeight light;
  FontWeight regular;
  FontWeight medium;
  FontWeight semiBold;
  FontWeight bold;
  FontWeight extraBold;
  FontWeight black;
}

class DSFontSize {
  DSFontSize({
    required this.us,
    required this.xxxs,
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.ul,
  });
  
  /// `12`
  double us;

  /// `14`
  double xxxs;

  /// `16`
  double xxs;

  /// `20`
  double xs;

  /// `24`
  double sm;

  /// `32`
  double md;

  /// `40`
  double lg;

  /// `48`
  double xl;

  /// `56`
  double xxl;

  /// `64`
  double xxxl;

  /// `80`
  double ul;
}
