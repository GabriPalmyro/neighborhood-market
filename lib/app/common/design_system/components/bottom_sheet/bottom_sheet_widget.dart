import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class DSBottomSheet extends StatelessWidget {
  const DSBottomSheet({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Wrap(
      children: [
        Center(
          child: Container(
            width: 45,
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.md,
              vertical: 2,
            ),
            margin: EdgeInsets.only(top: theme.spacing.inline.xxs),
            decoration: BoxDecoration(
              color: theme.colors.neutral.light.two,
              borderRadius: BorderRadius.circular(theme.borders.radius.medium),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

Future<T?> showDSBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  bool isScrollControlled = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useRootNavigator = false,
  RouteSettings? routeSettings,
}) async {
  final theme = DSTheme.getDesignTokensOf(context);
  final result = await showModalBottomSheet<T?>(
    context: context,
    clipBehavior: clipBehavior,
    constraints: constraints,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    backgroundColor: theme.colors.neutral.light.pure,
    builder: (context) {
      return DSBottomSheet(
        child: child,
      );
    },
  );

  return result;
}
