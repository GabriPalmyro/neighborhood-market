import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/presentation/widgets/product_gallery_success_widget.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/notifications/notifications_cubit.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/presentation/ad_banner_widget.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:neighborhood_market/app/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:neighborhood_market/app/features/wishlist/presentation/widgets/wishlist_loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({
    super.key,
  });

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    const badgeSize = 10.0;
    final theme = DSTheme.getDesignTokensOf(context);
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
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          return FadeSwitcherState<WishlistState, WishlistLoaded, WishlistError, WishlistLoading>(
            error: (_) {
              return MainPageErrorWidget(
                onRetry: () {
                  context.read<WishlistCubit>().getResult();
                },
              );
            },
            loading: (_) {
              return const Center(
                child: WishlistLoadingWidget(),
              );
            },
            result: (result) {
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () async {
                  await context.read<WishlistCubit>().getResult();
                  _refreshController.refreshCompleted();
                },
                child: CustomScrollView(
                  slivers: [
                    if (result.entity.adBanner != null) ...[
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          vertical: theme.spacing.inline.xxs,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: AdBannerWidget(
                            model: result.entity.adBanner!,
                            appNavigator: GetIt.I.get<AppNavigator>(),
                          ),
                        ),
                      ),
                    ],
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: result.entity.items.length,
                        (context, index) {
                          final product = result.entity.items[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.inline.xs,
                              vertical: theme.spacing.inline.xxs,
                            ),
                            child: ProductGallerySuccessWidget(
                              entity: product,
                              navigator: GetIt.I.get<AppNavigator>(),
                              onTapLiked: (id, _) {
                                context.read<WishlistCubit>().unlikeProduct(id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            state: state,
          );
        },
      ),
    );
  }
}
