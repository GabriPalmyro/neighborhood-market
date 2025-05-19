import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/home_cubit.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/home_state.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/notifications/notifications_cubit.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/presentation/ad_banner_widget.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/presentation/widget/filter_success_widget.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/home_loading_widget.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/presentation/widget/search_success_widget.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/presentation/widgets/shop_gallery_success_widget.dart';
import 'package:neighborhood_market/app/features/main/presentation/cubit/main_page_cubit.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.appNavigator,
    super.key,
  });

  final AppNavigator appNavigator;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> onFavorite(String id, bool isLiked) async {
    if (isLiked) {
      context.read<HomeCubit>().likeMostWantedShop(id, isLiked);
      ScaffoldMessenger.of(context).showSuccessSnackBar(
        context,
        content: 'Product removed from favorites',
      );
    } else {
      context.read<HomeCubit>().likeMostWantedShop(id, isLiked);
      ScaffoldMessenger.of(context).showSuccessSnackBar(
        context,
        content: 'Product added to favorites',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const badgeSize = 10.0;
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: TopbarWidget.imageTopBar(
            image: ThemeImage(
              ThemeImages.logoForeground,
              color: theme.colors.neutral.dark.pure,
              size: const Size.square(55),
            ),
            actions: [
              BlocBuilder<NotificationsHomeCubit, NotificationsHomeState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Badge(
                      isLabelVisible: state is NotificationsToRead,
                      smallSize: badgeSize,
                      child: DSIcon(
                        icon: DSIcons.notifications,
                        color: theme.colors.neutral.dark.icon,
                        size: DSIconSize.md,
                      ),
                    ),
                    onPressed: () {
                      GetIt.I.get<AppNavigator>().pushRoute(
                            Routes.notifications,
                          );
                    },
                  );
                },
              ),
            ],
          ),
          body: FadeSwitcherState<HomeState, HomeLoaded, HomeError, HomeLoading>(
            error: (_) {
              return MainPageErrorWidget(
                onRetry: () {
                  context.read<HomeCubit>().getResult();
                },
              );
            },
            loading: (_) {
              return const HomeLoadingWidget();
            },
            result: (result) {
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () async {
                  context.read<HomeCubit>().getResult();
                  _refreshController.refreshCompleted();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.spacing.inline.xs,
                          vertical: theme.spacing.inline.xxs,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context.read<HomeCubit>().sendSearchEvent();
                            context.read<MainPageCubit>().changePage(1);
                          },
                          child: const SearchSuccessWidget(
                            label: 'Search',
                            leadingIcon: DSIcons.search,
                            showClearButton: false,
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                    if (result.entity.adBanner != null) ...[
                      SliverPadding(
                        padding: EdgeInsets.only(
                          top: theme.spacing.inline.xxs,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: AdBannerWidget(
                            model: result.entity.adBanner!,
                            appNavigator: widget.appNavigator,
                          ),
                        ),
                      ),
                    ],
                    if (result.entity.filters != null && result.entity.filters!.items!.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: theme.spacing.inline.xs,
                          ),
                          child: FilterSuccessWidget(
                            model: result.entity.filters!,
                          ),
                        ),
                      ),
                    ],
                    if (result.entity.followedItems != null && result.entity.followedItems!.items.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: theme.spacing.inline.xs,
                            vertical: theme.spacing.inline.xs,
                          ),
                          child: ShopGallerySuccessWidget(
                            model: result.entity.followedItems!,
                            navigator: widget.appNavigator,
                            onFavorite: onFavorite,
                          ),
                        ),
                      ),
                    ],
                    if (result.entity.trending != null && result.entity.trending!.items.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: theme.spacing.inline.xs,
                            vertical: theme.spacing.inline.xs,
                          ),
                          child: ShopGallerySuccessWidget(
                            model: result.entity.trending!,
                            navigator: widget.appNavigator,
                            onFavorite: onFavorite,
                          ),
                        ),
                      ),
                    ],
                    if (result.entity.mostWanted != null && result.entity.mostWanted!.items.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: theme.spacing.inline.xs,
                            vertical: theme.spacing.inline.xs,
                          ),
                          child: ShopGallerySuccessWidget(
                            model: result.entity.mostWanted!,
                            navigator: widget.appNavigator,
                            onFavorite: onFavorite,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
            state: state,
          ),
        );
      },
    );
  }
}
