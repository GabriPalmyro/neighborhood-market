import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';

class MainAppbarWidget extends StatelessWidget {
  const MainAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    const badgeSize = 10.0;
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: TopbarWidget.imageTopBar(
          image: ThemeImage(
            ThemeImages.logo,
            color: theme.colors.neutral.dark.pure,
            size: const Size(120, 100),
          ),
          actions: [
            IconButton(
              icon: Badge(
                smallSize: badgeSize,
                child: DSIcon(
                  icon: DSIcons.notifications,
                  color: theme.colors.neutral.dark.icon,
                  size: DSIconSize.md,
                ),
              ),
              onPressed: () {
                GetIt.I.get<AppNavigator>().pushRoute(Routes.notifications);
              },
            ),
          ],
        ),
      ),
    );
  }
}
