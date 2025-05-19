import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons_data.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/design_system/core/tokens/design.dart';

class NavbarItemWidget extends StatelessWidget {
  const NavbarItemWidget({
    required this.label,
    required this.icon,
    required this.itemIndex,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final IconAssetData icon;
  final String label;
  final int currentIndex;
  final int itemIndex;
  final Function(int) onTap;

  Color _getIconColor(int index, int currentIndex, DSTokens theme) {
    return index == currentIndex ? theme.colors.neutral.dark.pure : theme.colors.neutral.light.two;
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(theme.borders.radius.small),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => itemIndex != currentIndex ? onTap.call(itemIndex) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DSIcon(
                icon: icon,
                color: _getIconColor(itemIndex, currentIndex, theme),
              ),
              DSText(
                label,
                customStyle: TextStyle(
                  color: _getIconColor(itemIndex, currentIndex, theme),
                  fontSize: theme.font.size.xxxs,
                  fontWeight: theme.font.weight.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
