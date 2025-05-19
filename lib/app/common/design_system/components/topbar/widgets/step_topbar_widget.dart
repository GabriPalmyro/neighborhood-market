import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

final toolbarHeight = defaultTargetPlatform == TargetPlatform.iOS ? 44.0 : kToolbarHeight;

class DSTopBarStep extends TopbarWidget {
  DSTopBarStep({
    required this.title,
    required this.totalSteps,
    required this.currentStep,
    this.actions,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingIconSize,
    this.onBack,
    this.backgroundColor,
    this.useLeadingButton = true,
    this.systemUiOverlayStyle,
    super.key,
  }) : preferredSize = Size.fromHeight(
          toolbarHeight + 1,
        );

  @override
  final Size preferredSize;

  final Widget? title;
  final int totalSteps;
  final int currentStep;
  final List<Widget>? actions;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? leadingIconSize;
  final Function? onBack;
  final Color? backgroundColor;
  final bool useLeadingButton;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return AppBar(
      title: title,
      actions: actions,
      leading: useLeadingButton
          ? IconButton(
              icon: leadingIcon ??
                  DSIcon(
                    icon: DSIcons.arrowBack,
                    size: DSIconSize.sm,
                    color: tokens.colors.neutral.dark.icon,
                  ),
              iconSize: leadingIconSize ?? 24,
              onPressed: () {
                if (onBack != null) {
                  onBack?.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
            )
          : null,
      centerTitle: true,
      elevation: 0,
      backgroundColor: backgroundColor ?? tokens.colors.neutral.light.pure,
      scrolledUnderElevation: 0,
      systemOverlayStyle: systemUiOverlayStyle,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: (MediaQuery.of(context).size.width / totalSteps) * currentStep,
            height: 1,
            color: tokens.colors.neutral.dark.pure,
          ),
        ),
      ),
    );
  }
}
