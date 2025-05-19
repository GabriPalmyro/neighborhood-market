import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart';
import 'package:neighborhood_market/app/common/design_system/components/navbar/navbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/main/presentation/cubit/main_page_cubit.dart';
import 'package:neighborhood_market/app/features/main/presentation/cubit/main_page_state.dart';

class MainTabsPage extends StatelessWidget {
  MainTabsPage({required this.appNavigator, super.key})
      : homePage = GetIt.I.get<ComponentsPageFactory>(instanceName: 'HomePageFactory').create(),
        explorePage = GetIt.I.get<ComponentsPageFactory>(instanceName: 'ExplorePageFactory').create(),
        wishlistPage = GetIt.I.get<ComponentsPageFactory>(instanceName: 'WishlistPageFactory').create(),
        profilePage = GetIt.I.get<ComponentsPageFactory>(instanceName: 'ProfilePageFactory').create();

  final AppNavigator appNavigator;
  final Widget homePage;
  final Widget explorePage;
  final Widget wishlistPage;
  final Widget profilePage;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => {
        context.read<MainPageCubit>().changePage(1),
      },
      child: BlocBuilder<MainPageCubit, MainPageState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colors.neutral.light.pure,
            bottomNavigationBar: CustomBottomNavBar(
              appNavigator: appNavigator,
              currentIndex: (state as MainPageChangePage).index,
              onTap: (index) {
                context.read<MainPageCubit>().changePage(index);
              },
            ),
            body: PageStorage(
              bucket: PageStorageBucket(),
              child: IndexedStack(
                index: state.index,
                children: [
                  homePage,
                  explorePage,
                  wishlistPage,
                  profilePage,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
