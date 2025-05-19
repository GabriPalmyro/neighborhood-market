import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

final toolbarHeight = defaultTargetPlatform == TargetPlatform.iOS ? 44.0 : kToolbarHeight;

class DSTopBarDefault extends TopbarWidget {
  DSTopBarDefault({
    required this.title,
    this.actions,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingIconSize,
    this.onBack,
    this.bottom,
    this.backgroundColor,
    this.useLeadingButton = true,
    this.enableBackButton = true,
    this.centerTitle = true,
    this.systemUiOverlayStyle,
    super.key,
  }) : preferredSize = Size.fromHeight(
          toolbarHeight + (bottom?.preferredSize.height ?? 0),
        );

  @override
  final Size preferredSize;

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? leadingIconSize;
  final Function? onBack;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final bool enableBackButton;
  final bool useLeadingButton;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final bool centerTitle;

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
      automaticallyImplyLeading: enableBackButton,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? tokens.colors.neutral.light.pure,
      systemOverlayStyle: systemUiOverlayStyle,
      bottom: bottom,
    );
  }
}
