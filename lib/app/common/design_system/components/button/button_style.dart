import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_tokens.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';

class DSButtonStyle {
  DSButtonStyle({required this.tokens});
  final DSButtonTokens tokens;

  double get borderRadius => tokens.borderRadius;

  Color backgroundColor(DSButtonType type) {
    switch (type) {
      case DSButtonType.primary:
        return tokens.backgroundColorPrimary;
      case DSButtonType.secondary:
        return tokens.backgroundColorSecondary;
      case DSButtonType.primaryOutline:
        return tokens.backgroundColorDisable;
      case DSButtonType.secondaryOutline:
        return tokens.backgroundColorDisable;
      case DSButtonType.warning:
        return tokens.backgroundColorError;
      case DSButtonType.warningOutline:
        return tokens.backgroundColorDisable;
      case DSButtonType.ghost:
        return tokens.backgroundColorGhost;
    }
  }

  Color borderColor(DSButtonType type) {
    switch (type) {
      case DSButtonType.primaryOutline || DSButtonType.warningOutline:
        return const Color(0xFFE6E6E6);
      case DSButtonType.secondary:
        return tokens.borderColorSecondary;
      case DSButtonType.secondaryOutline:
        return tokens.backgroundColorSecondary;
      default:
        return Colors.transparent;
    }
  }

  double borderWidth(DSButtonType type) {
    switch (type) {
      case DSButtonType.primaryOutline || DSButtonType.secondaryOutline || DSButtonType.warningOutline:
        return 1;
      default:
        return 0;
    }
  }

  Border? border(DSButtonType type) {
    if (type == DSButtonType.secondary || type == DSButtonType.primary) {
      return null;
    }
    
    return Border.all(
      color: borderColor(type),
      width: borderWidth(type),
    );
  }

  Color textColor(DSButtonType type, bool isDisable) {
    if (isDisable) {
      return tokens.textColorDisable;
    }
    switch (type) {
      case DSButtonType.primary:
        return tokens.textColor;
      case DSButtonType.secondary:
        return tokens.textColor;
      case DSButtonType.primaryOutline:
        return tokens.backgroundColorPrimary;
      case DSButtonType.secondaryOutline:
        return tokens.backgroundColorSecondary; 
      case DSButtonType.warning:
        return tokens.textColor;
      case DSButtonType.warningOutline:
        return tokens.backgroundColorError;
      case DSButtonType.ghost:
        return tokens.textColorDisable;
    }
  }

  double height(DSButtonSize size) {
    switch (size) {
      case DSButtonSize.lg:
        return tokens.heightLarge;
      case DSButtonSize.md:
        return tokens.heightMedium;
      case DSButtonSize.sm:
        return tokens.heightSmall;
    }
  }

  double fontSize(DSButtonSize size) {
    switch (size) {
      case DSButtonSize.lg:
        return tokens.fontSizeLarge;
      case DSButtonSize.md:
        return tokens.fontSizeMedium;
      case DSButtonSize.sm:
        return tokens.fontSizeSmall;
    }
  }
}
