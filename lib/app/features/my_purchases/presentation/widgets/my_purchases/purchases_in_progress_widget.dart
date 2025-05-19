import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/loading/loading_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_props.dart';
import 'package:neighborhood_market/app/common/design_system/components/product_item/product_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/scroll_mixin.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/bottom_loader/bottom_loader_widget.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchases_in_progress_cubit.dart';

class PurchasesInProgressWidget extends StatefulWidget {
  const PurchasesInProgressWidget({required this.appNavigator, super.key});

  final AppNavigator appNavigator;

  @override
  State<PurchasesInProgressWidget> createState() => _PurchasesInProgressWidgetState();
}

class _PurchasesInProgressWidgetState extends State<PurchasesInProgressWidget> with ScrollMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<PurchasesInProgressCubit>().state;

    if (state is PurchasesInProgressLoading) {
      return;
    }

    if (isBottom && state is PurchasesInProgressLoaded && !state.hasReachedMax) {
      context.read<PurchasesInProgressCubit>().loadMorePurchases();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  ScrollController get scrollController => _scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<PurchasesInProgressCubit, PurchasesInProgressState>(
      builder: (context, state) {
        return FadeSwitcher(
          child: () {
            if (state is PurchasesInProgressLoading) {
              return const LoadingWidget();
            } else if (state is PurchasesInProgressLoaded) {
              return ListView.builder(
                key: const PageStorageKey<String>('purchasesInProgressList'),
                controller: _scrollController,
                itemCount: state.hasReachedMax ? state.purchases.length : state.purchases.length + 1,
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.inline.xs,
                  vertical: theme.spacing.inline.xs,
                ),
                itemBuilder: (context, index) {
                  if (index >= state.purchases.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: BottomLoader(),
                    );
                  }
                  final purchase = state.purchases[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: theme.spacing.inline.xs,
                    ),
                    child: ProductItemWidget(
                      onTap: () {
                        widget.appNavigator.pushRoute(
                          Routes.myPurchaseDetails,
                          queryParameters: {
                            'purchaseId': purchase.id ?? '',
                          },
                        );
                      },
                      props: ProductItemProps(
                        title: purchase.title ?? '',
                        badges: purchase.tags,
                        imageUrl: purchase.image ?? '',
                        price: purchase.price,
                      ),
                    ),
                  );
                },
              );
            } else {
              return MainPageErrorWidget(
                onRetry: () {
                  context.read<PurchasesInProgressCubit>().loadPurchases();
                },
              );
            }
          }(),
        );
      },
    );
  }
}
