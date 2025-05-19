import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/widgets/default_topbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/widgets/logo_topbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/widgets/step_topbar_widget.dart';

abstract class TopbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopbarWidget({super.key});

  factory TopbarWidget.defaultTopBar({
    Widget? title,
    List<Widget>? actions,
    Widget? leadingIcon,
    Widget? trailingIcon,
    double? leadingIconSize,
    Function? onBack,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
    bool useLeadingButton = true,
    bool enableBackButton = true,
    bool centerTitle = true,
    SystemUiOverlayStyle? systemUiOverlayStyle,
  }) {
    return DSTopBarDefault(
      title: title,
      actions: actions,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      leadingIconSize: leadingIconSize,
      onBack: onBack,
      bottom: bottom,
      backgroundColor: backgroundColor,
      useLeadingButton: useLeadingButton,
      systemUiOverlayStyle: systemUiOverlayStyle,
      centerTitle: centerTitle,
      enableBackButton: enableBackButton,
    );
  }

  factory TopbarWidget.imageTopBar({
    Widget? image,
    List<Widget>? actions,
    Function? onBack,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
    SystemUiOverlayStyle? systemUiOverlayStyle,
  }) {
    return DSTopBarLogo(
      image: image,
      actions: actions,
      onBack: onBack,
      bottom: bottom,
      backgroundColor: backgroundColor,
      systemUiOverlayStyle: systemUiOverlayStyle,
    );
  }

  factory TopbarWidget.stepsTopBar({
    required Widget title,
    required int totalSteps,
    required int currentStep,
    List<Widget>? actions,
    Widget? leadingIcon,
    Widget? trailingIcon,
    double? leadingIconSize,
    Function? onBack,
    Color? backgroundColor,
    bool useLeadingButton = true,
    SystemUiOverlayStyle? systemUiOverlayStyle,
  }) {
    return DSTopBarStep(
      title: title,
      totalSteps: totalSteps,
      currentStep: currentStep,
      actions: actions,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      leadingIconSize: leadingIconSize,
      onBack: onBack,
      backgroundColor: backgroundColor,
      useLeadingButton: useLeadingButton,
      systemUiOverlayStyle: systemUiOverlayStyle,
    );
  }
}
