import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_style.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class DSButton extends StatelessWidget {
  const DSButton({
    required this.label,
    required this.onPressed,
    this.size = DSButtonSize.sm,
    this.type = DSButtonType.primary,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final DSButtonSize size;
  final DSButtonType type;
  final bool isLoading;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context).button;
    final buttonStyle = DSButtonStyle(tokens: theme);

    return Semantics(
      button: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(buttonStyle.borderRadius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : onPressed,
            child: Ink(
              height: buttonStyle.height(size),
              width: double.infinity,
              decoration: BoxDecoration(
                border: buttonStyle.border(type),
                color: buttonStyle.backgroundColor(type),
                borderRadius: BorderRadius.circular(buttonStyle.borderRadius),
              ),
              child: Center(
                child: FadeSwitcher(
                  child: isLoading
                      ? SizedBox.fromSize(
                          size: Size.square(buttonStyle.height(size) * 0.5),
                          child: SpinKitFadingCircle(
                            color: buttonStyle.textColor(type, false),
                            size: 20,
                          ),
                        )
                      : DSText(
                          label,
                          textAlign: TextAlign.center,
                          customStyle: TextStyle(
                            color: buttonStyle.textColor(type, false),
                            fontSize: buttonStyle.fontSize(size),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
