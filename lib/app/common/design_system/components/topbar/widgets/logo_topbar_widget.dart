import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

const toolbarHeight = 60.0;

class DSTopBarLogo extends TopbarWidget {
  DSTopBarLogo({
    this.image,
    this.actions,
    this.onBack,
    this.bottom,
    this.backgroundColor,
    this.systemUiOverlayStyle,
    super.key,
  }) : preferredSize = Size.fromHeight(
          toolbarHeight + (bottom?.preferredSize.height ?? 0),
        );

  @override
  final Size preferredSize;

  final Widget? image;
  final List<Widget>? actions;
  final Function? onBack;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return AppBar(
      title: image,
      actions: actions,
      leading: null,
      centerTitle: false,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: backgroundColor ?? tokens.colors.neutral.light.pure,
      systemOverlayStyle: systemUiOverlayStyle,
      bottom: bottom,
    );
  }
}
