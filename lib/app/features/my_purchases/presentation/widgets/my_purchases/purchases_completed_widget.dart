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
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchases_completed_cubit.dart';

class PurchasesCompletedWidget extends StatefulWidget {
  const PurchasesCompletedWidget({required this.appNavigator, super.key});

  final AppNavigator appNavigator;

  @override
  State<PurchasesCompletedWidget> createState() => _PurchasesCompletedWidgetState();
}

class _PurchasesCompletedWidgetState extends State<PurchasesCompletedWidget> with ScrollMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<PurchasesCompletedCubit>().state;

    if (state is PurchasesCompletedLoading) {
      return;
    }

    if (isBottom && state is PurchasesCompletedLoaded && !state.hasReachedMax) {
      context.read<PurchasesCompletedCubit>().loadMorePurchases();
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
    return BlocBuilder<PurchasesCompletedCubit, PurchasesCompletedState>(
      builder: (context, state) {
        return FadeSwitcher(
          child: () {
            if (state is PurchasesCompletedLoading) {
              return const LoadingWidget();
            } else if (state is PurchasesCompletedLoaded) {
              return ListView.builder(
                key: const PageStorageKey<String>('purchasesCompletedList'),
                itemCount: state.purchases.length,
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.inline.xs,
                  vertical: theme.spacing.inline.xs,
                ),
                itemBuilder: (context, index) {
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
                        isValueCheck: true,
                      ),
                    ),
                  );
                },
              );
            } else {
              return MainPageErrorWidget(
                onRetry: () {
                  context.read<PurchasesCompletedCubit>().loadPurchases();
                },
              );
            }
          }(),
        );
      },
    );
  }
}
