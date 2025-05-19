import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/scroll_mixin.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/explore_state.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/bottom_loader/bottom_loader_widget.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/explore_loading_widget.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/presentation/widgets/product_gallery_success_widget.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/notifications/notifications_cubit.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/presentation/ad_banner_widget.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/presentation/widget/search_success_widget.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({
    super.key,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with ScrollMixin {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final _refreshController = RefreshController(initialRefresh: false);
  final _scrollController = ScrollController();

  bool isLoadingMoreItens = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    final hasReachedMax = context.read<ExploreCubit>().state.hasReachedMax;
    final isLoading = context.read<ExploreCubit>().state.status == ExploreStatus.loading;
    if (isBottom && !isLoading && !hasReachedMax && !isLoadingMoreItens) {
      setState(() => isLoadingMoreItens = true);
      await context.read<ExploreCubit>().getMoreProducts();
      setState(() => isLoadingMoreItens = false);
    }
  }

  
  @override
  ScrollController get scrollController => _scrollController;

  @override
  Widget build(BuildContext context) {
    const badgeSize = 10.0;
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocConsumer<ExploreCubit, ExploreState>(
      listener: (context, state) {
        if (state.status == ExploreStatus.failure) {
          ScaffoldMessenger.of(context).showErrorSnackBar(
            context,
            content: 'An error occurred. Please try again later.',
          );
        } else if (state.status == ExploreStatus.success) {
          searchController.text = state.filters.search ?? '';
        }
      },
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
          body: FadeSwitcher(
            child: () {
              switch (state.status) {
                case ExploreStatus.loading || ExploreStatus.initial:
                  return const ExploreLoadingWidget();
                case ExploreStatus.success:
                  return SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () async {
                      context.read<ExploreCubit>().getProducts(refresh: true);
                      _refreshController.refreshCompleted();
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(height: theme.spacing.inline.xxs),
                        ),
                        BlocBuilder<ExploreCubit, ExploreState>(
                          builder: (context, state) {
                            return SliverAppBar(
                              pinned: false,
                              floating: true,
                              automaticallyImplyLeading: false,
                              backgroundColor: theme.colors.neutral.light.pure,
                              surfaceTintColor: theme.colors.neutral.light.pure,
                              flexibleSpace: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: theme.spacing.inline.xs,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: SearchSuccessWidget(
                                            label: 'Search',
                                            controller: searchController,
                                            focusNode: context.read<ExploreCubit>().searchFocusNode,
                                            showClearButton: false,
                                            leadingIcon: DSIcons.search,
                                            onTapOutside: (_) {
                                              context.read<ExploreCubit>().searchFocusNode.unfocus();
                                            },
                                            onChanged: (query) {
                                              setState(() {});
                                            },
                                            onSubmitted: (query) {
                                              context.read<ExploreCubit>().getProducts(
                                                    search: true,
                                                    filters: state.filters.copyWith(search: query),
                                                  );
                                            },
                                          ),
                                        ),
                                        SizedBox(width: theme.spacing.inline.xs),
                                        GestureDetector(
                                          onTap: () {
                                            final Map<String, String> queries = Map<String, String>.from(
                                              state.filters.toFilterJson(),
                                            );

                                            GetIt.I.get<AppNavigator>().pushRoute(
                                                  Routes.filter,
                                                  queryParameters: queries,
                                                );
                                          },
                                          child: DSIcon(
                                            icon: DSIcons.categories,
                                            color: theme.colors.neutral.light.icon,
                                          ),
                                        ),
                                        SizedBox(width: theme.spacing.inline.xs),
                                        GestureDetector(
                                          onTap: () {
                                            GetIt.I.get<AppNavigator>().pushRoute(
                                                  Routes.filterCategory,
                                                );
                                          },
                                          child: DSIcon(
                                            icon: DSIcons.filter,
                                            color: theme.colors.neutral.light.icon,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        if (state.adBanner != null) ...[
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                              vertical: theme.spacing.inline.xxs,
                            ),
                            sliver: SliverToBoxAdapter(
                              child: AdBannerWidget(
                                model: state.adBanner!,
                                appNavigator: GetIt.I.get<AppNavigator>(),
                              ),
                            ),
                          ),
                        ],
                        if (state.hasFilters())
                          SliverAppBar(
                            pinned: true,
                            floating: false,
                            toolbarHeight: 35,
                            backgroundColor: theme.colors.neutral.light.pure,
                            surfaceTintColor: theme.colors.neutral.light.pure,
                            flexibleSpace: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: theme.spacing.inline.xs,
                                vertical: theme.spacing.inline.xxs,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  searchController.clear();
                                  context.read<ExploreCubit>().getProducts(
                                        refresh: true,
                                      );
                                },
                                child: DSText(
                                  'Clear Filters',
                                  customStyle: TextStyle(
                                    fontSize: theme.font.size.xxs,
                                    color: theme.colors.neutral.dark.icon,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (state.products.isEmpty) ...[
                          SliverFillRemaining(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const DSIcon(
                                    icon: DSIcons.box,
                                    size: DSIconSize.xl,
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: theme.spacing.inline.sm,
                                    ),
                                    child: DSText(
                                      'No products found',
                                      textAlign: TextAlign.center,
                                      customStyle: TextStyle(
                                        fontSize: theme.font.size.xs,
                                        color: theme.colors.neutral.dark.icon,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ] else ...[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.products.length,
                              (context, index) {
                                final product = state.products[index];
                                final hasReachedMax = state.hasReachedMax;
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: theme.spacing.inline.xxs,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: theme.spacing.inline.xs,
                                        ),
                                        child: ProductGallerySuccessWidget(
                                          entity: product,
                                          navigator: GetIt.I.get<AppNavigator>(),
                                          onTapLiked: (id, isLiked) {
                                            if (isLiked) {
                                              context.read<ExploreCubit>().unlikeProduct(id);
                                              ScaffoldMessenger.of(context).showSuccessSnackBar(
                                                context,
                                                content: 'Product removed from favorites',
                                              );
                                            } else {
                                              context.read<ExploreCubit>().likeProduct(id);
                                              ScaffoldMessenger.of(context).showSuccessSnackBar(
                                                context,
                                                content: 'Product added to favorites',
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      if ((index + 1) % 10 == 0 && index != state.products.length - 1) ...[
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: theme.spacing.inline.xs,
                                          ),
                                          child: AdBannerWidget(
                                            model: state.adBanner!,
                                            appNavigator: GetIt.I.get<AppNavigator>(),
                                          ),
                                        ),
                                      ],
                                      if (index == state.products.length - 1 && !hasReachedMax) ...[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: theme.spacing.inline.xs,
                                          ),
                                          child: const BottomLoader(),
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                case ExploreStatus.failure:
                  return MainPageErrorWidget(
                    onRetry: () {
                      context.read<ExploreCubit>().getProducts();
                    },
                  );
              }
            }(),
          ),
        );
      },
    );
  }
}
