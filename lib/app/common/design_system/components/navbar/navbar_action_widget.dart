import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class NavbarActionWidget extends StatelessWidget {
  const NavbarActionWidget({
    required this.onTap,
    super.key,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: theme.colors.neutral.dark.pure.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          theme.borders.radius.circular,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Ink(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: theme.colors.neutral.dark.pure,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: theme.colors.neutral.light.one,
                size: 28.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
