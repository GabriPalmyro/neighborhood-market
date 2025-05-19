import 'package:flutter/material.dart';

import '../../tokens/design/font.dart';

class BaseDSThemeFont implements DSThemeFont {
  BaseDSThemeFont();

  @override
  DSFontFamily family = BaseDSThemeFontFamily();

  @override
  DSFontWeight weight = BaseDSThemeFontWeight();

  @override
  DSFontSize size = BaseDSThemeFontSize();
}

class BaseDSThemeFontFamily implements DSFontFamily {
  BaseDSThemeFontFamily({String? base}) {
    this.base = base ?? this.base;
  }

  @override
  String base = 'Inter';
}

class BaseDSThemeFontWeight implements DSFontWeight {
  BaseDSThemeFontWeight({
    FontWeight? thin,
    FontWeight? extraLight,
    FontWeight? light,
    FontWeight? regular,
    FontWeight? medium,
    FontWeight? semiBold,
    FontWeight? bold,
    FontWeight? extraBold,
    FontWeight? black,
  }) {
    this.thin = thin ?? this.thin;
    this.extraLight = extraLight ?? this.extraLight;
    this.light = light ?? this.light;
    this.regular = regular ?? this.regular;
    this.medium = medium ?? this.medium;
    this.semiBold = semiBold ?? this.semiBold;
    this.bold = bold ?? this.bold;
    this.extraBold = extraBold ?? this.extraBold;
    this.black = black ?? this.black;
  }

  @override
  FontWeight thin = FontWeight.w100;

  @override
  FontWeight extraLight = FontWeight.w200;

  @override
  FontWeight light = FontWeight.w300;

  @override
  FontWeight regular = FontWeight.w400;

  @override
  FontWeight medium = FontWeight.w500;

  @override
  FontWeight semiBold = FontWeight.w600;

  @override
  FontWeight bold = FontWeight.w700;

  @override
  FontWeight extraBold = FontWeight.w800;

  @override
  FontWeight black = FontWeight.w900;
}

class BaseDSThemeFontSize implements DSFontSize {
  BaseDSThemeFontSize({
    double? xxxs,
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
  }) {
    this.xxxs = xxxs ?? this.xxxs;
    this.xxs = xxs ?? this.xxs;
    this.xs = xs ?? this.xs;
    this.sm = sm ?? this.sm;
    this.md = md ?? this.md;
    this.lg = lg ?? this.lg;
    this.xl = xl ?? this.xl;
    this.xxl = xxl ?? this.xxl;
    this.xxxl = xxxl ?? this.xxxl;
  }

  @override
  double us = 10;

  @override
  double xxxs = 12;

  @override
  double xxs = 14;

  @override
  double xs = 16;

  @override
  double sm = 20;

  @override
  double md = 24;

  @override
  double lg = 32;

  @override
  double xl = 48;

  @override
  double xxl = 64;

  @override
  double xxxl = 80;

  @override
  double ul = 96;
}
