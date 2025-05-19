import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/navbar/navbar_action_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/navbar/navbar_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.appNavigator,
    super.key,
  });

  final int currentIndex;
  final Function(int) onTap;
  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colors.neutral.light.one,
            width: theme.borderWidth.thin,
          ),
        ),
      ),
      child: BottomAppBar(
        elevation: 0,
        height: 75.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Home
            Expanded(
              child: NavbarItemWidget(
                label: 'Home',
                icon: DSIcons.home,
                itemIndex: 0,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
            ),
            SizedBox(width: theme.spacing.inline.xs),
            // Explore
            Expanded(
              child: NavbarItemWidget(
                label: 'Explore',
                icon: DSIcons.searchFilled,
                itemIndex: 1,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
            ),
            //Action
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.inline.xs,
              ),
              child: NavbarActionWidget(
                onTap: () {
                  appNavigator.pushRoute(Routes.selectProductCategory);
                },
              ),
            ),
            // Wishlist
            Expanded(
              child: NavbarItemWidget(
                label: 'Wishlist',
                icon: DSIcons.heartFilled,
                itemIndex: 2,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
            ),
            SizedBox(width: theme.spacing.inline.xs),
            // Profile
            Expanded(
              child: NavbarItemWidget(
                label: 'Profile',
                icon: DSIcons.profile,
                itemIndex: 3,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
