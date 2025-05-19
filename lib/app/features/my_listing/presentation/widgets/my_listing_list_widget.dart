import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_props.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/scroll_mixin.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/bottom_loader/bottom_loader_widget.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/my_listing/domain/entities/my_listing_type.dart';
import 'package:neighborhood_market/app/features/my_listing/presentation/cubit/my_listing_cubit.dart';
import 'package:neighborhood_market/app/features/my_listing/presentation/widgets/listing_actions_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyListingListWidget extends StatefulWidget {
  const MyListingListWidget({
    required this.type,
    required this.list,
    this.isValueCheck = false,
    super.key,
  });

  final MyListingType type;
  final List<ProductGalleryItemModel> list;
  final bool isValueCheck;

  @override
  State<MyListingListWidget> createState() => _MyListingListWidgetState();
}

class _MyListingListWidgetState extends State<MyListingListWidget> with ScrollMixin {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();

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
    final state = context.read<MyListingCubit>().state;

    if (state is MyListingLoading) {
      return;
    }

    if (isBottom && state is MyListingLoaded && !state.hasReachedMax) {
      context.read<MyListingCubit>().loadMore(widget.type);
    }
  }

  @override
  ScrollController get scrollController => _scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: () {
        context.read<MyListingCubit>().getMyListing(type: widget.type);
      },
      child: ListView.builder(
        controller: _scrollController,
        key: PageStorageKey<String>(widget.type.toString()),
        itemCount: widget.list.length,
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.inline.xs,
          vertical: theme.spacing.inline.xs,
        ),
        itemBuilder: (context, index) {
          final item = widget.list[index];
          final currentState = context.read<MyListingCubit>().state as MyListingLoaded;
          final isLoadingMore = currentState.isLoadingMore && index == widget.list.length - 1;
          return Padding(
            padding: EdgeInsets.only(
              bottom: theme.spacing.inline.xs,
            ),
            child: Column(
              children: [
                ProductItemWidget(
                  onTap: widget.type != MyListingType.canceled
                      ? () {
                          GetIt.I.get<AppNavigator>().pushRoute(
                            Routes.product,
                            queryParameters: {
                              'id': widget.list[index].id ?? '',
                            },
                          );
                        }
                      : null,
                  props: ProductItemProps(
                    title: item.title ?? '',
                    badges: item.tags,
                    imageUrl: item.image ?? '',
                    price: item.price,
                    trailing: widget.type == MyListingType.published
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: theme.spacing.inline.xxxs,
                              right: theme.spacing.inline.xxxs,
                            ),
                            child: ClickableWidget(
                              borderRadius: BorderRadius.circular(theme.borders.radius.circular),
                              onTap: () {
                                showDSBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  child: ListingActionsBottomSheet(
                                    productId: item.id ?? '',
                                    appNavigator: GetIt.I.get<AppNavigator>(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(theme.spacing.inline.xxxs),
                                child: DSIcon(
                                  icon: DSIcons.verticalDots,
                                  color: theme.colors.neutral.dark.icon,
                                  size: DSIconSize.sm,
                                ),
                              ),
                            ),
                          )
                        : null,
                    isValueCheck: widget.isValueCheck,
                    views: item.views,
                  ),
                ),
                if (isLoadingMore) ...[
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
    );
  }
}
