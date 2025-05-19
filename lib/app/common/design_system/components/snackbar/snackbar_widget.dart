import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart' as snackbar;
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

enum SnackBarType { success, error, warning, info }

Color getSnackBarColor(BuildContext context, SnackBarType type) {
  final theme = DSTheme.getDesignTokensOf(context);
  switch (type) {
    case SnackBarType.success:
      return theme.colors.feedback.success;
    case SnackBarType.error:
      return theme.colors.feedback.error;
    case SnackBarType.warning:
      return theme.colors.feedback.warning;
    case SnackBarType.info:
      return theme.colors.neutral.dark.three;
  }
}

extension SnackbarWidgetExtension on ScaffoldMessengerState {
  void showDSSnackBar(
    BuildContext context, {
    required Widget content,
    double elevation = 0,
    Duration? duration,
    SnackBarAction? action,
    SnackBarType type = SnackBarType.info,
  }) {
    final theme = DSTheme.getDesignTokensOf(context);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // behavior: SnackBarBehavior.floating,
        backgroundColor: getSnackBarColor(context, type),
        content: content,
        elevation: elevation,
        duration: duration ?? const Duration(milliseconds: 3500),
        action: action,
        // margin: EdgeInsets.only(
        //   left: theme.spacing.inline.xs,
        //   right: theme.spacing.inline.xs,
        //   bottom: theme.spacing.inline.xs,
        // ),
        padding: EdgeInsets.symmetric(
          vertical: theme.spacing.inline.xs,
          horizontal: theme.spacing.inline.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(theme.borders.radius.medium),
            topRight: Radius.circular(theme.borders.radius.medium),
          ),
        ),
      ),
    );
  }

  void showSuccessSnackBar(
    BuildContext context, {
    required String content,
    Duration? duration,
  }) {
    final theme = DSTheme.getDesignTokensOf(context);

    snackbar.IconSnackBar.show(
      context,
      snackBarType: snackbar.SnackBarType.success,
      label: content,
      duration: duration,
      maxLines: 2,
      labelTextStyle: TextStyle(
        color: theme.colors.neutral.light.one,
        fontSize: theme.font.size.xxs,
        fontWeight: theme.font.weight.semiBold,
      ),
    );
  }

  void showErrorSnackBar(
    BuildContext context, {
    required String content,
    Duration? duration,
  }) {
    final theme = DSTheme.getDesignTokensOf(context);

    snackbar.IconSnackBar.show(
      context,
      snackBarType: snackbar.SnackBarType.fail,
      label: content,
      duration: duration,
      maxLines: 2,
      labelTextStyle: TextStyle(
        color: theme.colors.neutral.light.one,
        fontSize: theme.font.size.xxs,
        fontWeight: theme.font.weight.semiBold,
      ),
    );
  }

  void showInfoSnackBar(
    BuildContext context, {
    required String content,
    Duration? duration,
  }) {
    final theme = DSTheme.getDesignTokensOf(context);

    snackbar.IconSnackBar.show(
      context,
      snackBarType: snackbar.SnackBarType.alert,
      label: content,
      duration: duration,
      labelTextStyle: TextStyle(
        color: theme.colors.neutral.light.one,
        fontSize: theme.font.size.xxs,
        fontWeight: theme.font.weight.semiBold,
      ),
    );
  }
}
