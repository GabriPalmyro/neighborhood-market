import 'package:neighborhood_market/app/common/design_system/components/button/button_tokens.dart';

import 'design/borders.dart';
import 'design/colors.dart';
import 'design/font.dart';
import 'design/shadow.dart';
import 'design/spacing.dart';

abstract class DSTokens {
  DSTokens({
    required this.colors,
    required this.font,
    required this.spacing,
    required this.borderWidth,
    required this.borders,
    required this.button,
    required this.shadow,
  });

  final DSBorder borders;
  final DSThemeColor colors;
  final DSThemeFont font;
  final DSThemeSpacing spacing;
  final DSBorderWidth borderWidth;
  final DSButtonTokens button;
  final DSShadow shadow;
}
