import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/base/base.dart';

abstract class DSButtonTokens {
  DSButtonTokens({
    required this.borderRadius,
    required this.textColor,
    required this.backgroundColorPrimary,
    required this.backgroundColorSecondary,
    required this.borderWithSecondary,
    required this.borderColorSecondary,
    required this.backgroundColorGhost,
    required this.backgroundColorDisable,
    required this.borderColorDisable,
    required this.textColorDisable,
    required this.backgroundColorError,
    required this.borderWithError,
    required this.borderColorError,
    required this.textColorError,
    required this.heightLarge,
    required this.fontSizeLarge,
    required this.paddingHorizotalLarge,
    required this.heightMedium,
    required this.fontSizeMedium,
    required this.paddingHorizotalMedium,
    required this.heightSmall,
    required this.fontSizeSmall,
    required this.paddingHorizotalSmall,
    required this.minWidthLarge,
    required this.minWidthMedium,
    required this.minWidthSmall,
  });

  // base
  final double borderRadius;
  final Color textColor;

  // type primary
  final Color backgroundColorPrimary;

  // type secondary
  final Color backgroundColorSecondary;
  final double borderWithSecondary;
  final Color borderColorSecondary;

  // type error
  final Color backgroundColorError;
  final double borderWithError;
  final Color borderColorError;
  final Color textColorError;

  // type ghost
  final Color backgroundColorGhost;

  // State Disable
  final Color backgroundColorDisable;
  final Color borderColorDisable;
  final Color textColorDisable;

  // Size - Large
  final double heightLarge;
  final double minWidthLarge;
  final double fontSizeLarge;
  final double paddingHorizotalLarge;

  // Size - Medium
  final double heightMedium;
  final double minWidthMedium;
  final double fontSizeMedium;
  final double paddingHorizotalMedium;

  // Size - Small
  final double heightSmall;
  final double minWidthSmall;
  final double fontSizeSmall;
  final double paddingHorizotalSmall;
}

class BaseButtonTokens implements DSButtonTokens {
  BaseButtonTokens({required this.designToken});
  BaseDSDesignToken designToken;

  @override
  double get borderRadius => designToken.borders.radius.circular;

  @override
  Color get textColor => designToken.colors.neutral.light.pure;

  @override
  Color get backgroundColorPrimary => designToken.colors.brand.primary;

  @override
  Color get backgroundColorSecondary => designToken.colors.brand.secondary;

  @override
  double get borderWithSecondary => designToken.borders.radius.medium;

  @override
  Color get borderColorSecondary => designToken.colors.neutral.light.pure;

  @override
  Color get backgroundColorGhost => const Color(0xFFDEDEDE);

  @override
  Color get backgroundColorDisable => designToken.colors.neutral.light.pure;

  @override
  Color get borderColorDisable => designToken.colors.neutral.light.pure;

  @override
  Color get textColorDisable => const Color(0xFF959595);

  @override
  double get borderWithError => designToken.borders.radius.medium;

  @override
  Color get backgroundColorError => designToken.colors.feedback.error;

  @override
  Color get borderColorError => designToken.colors.feedback.error;

  @override
  Color get textColorError => designToken.colors.feedback.error;

  // Size - Large
  @override
  double get heightLarge => 64;

  @override
  double get minWidthLarge => 148;

  @override
  double get fontSizeLarge => designToken.font.size.sm;

  @override
  double get paddingHorizotalLarge => designToken.spacing.inline.md;

  // Size - Medium
  @override
  double get heightMedium => 48;

  @override
  double get minWidthMedium => 108;

  @override
  double get fontSizeMedium => designToken.font.size.xs;

  @override
  double get paddingHorizotalMedium => designToken.spacing.inline.sm;

  // Size - Small
  @override
  double get heightSmall => 40;

  @override
  double get minWidthSmall => 84;

  @override
  double get fontSizeSmall => designToken.font.size.xxs;

  @override
  double get paddingHorizotalSmall => designToken.spacing.inline.xs;
}
