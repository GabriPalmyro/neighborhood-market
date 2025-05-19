import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/product/presentation/cubit/image_full_view/image_full_view_cubit.dart';
import 'package:neighborhood_market/app/features/product/presentation/cubit/product_details_cubit.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/image_full_view/image_full_view_widget.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_loading_widget.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_success_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    required this.productId,
    required this.imageFullViewCubit,
    required this.detailsCubit,
    required this.appNavigator,
    super.key,
  });

  final String productId;
  final ImageFullViewCubit imageFullViewCubit;
  final ProductDetailsCubit detailsCubit;
  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => detailsCubit
            ..getProductDetails(productId)
            ..initUpdateProjectStream(productId),
        ),
        BlocProvider(
          create: (context) => imageFullViewCubit,
        ),
      ],
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colors.neutral.light.pure,
            body: FadeSwitcher(
              child: () {
                switch (state.runtimeType) {
                  case const (ProductDetailsLoaded):
                    state as ProductDetailsLoaded;
                    return Stack(
                      children: [
                        ProductSuccessWidget(
                          product: state.product,
                          appNavigator: appNavigator,
                          showShareButton: state.showShareButton,
                        ),
                        BlocBuilder<ImageFullViewCubit, ImageFullViewState>(
                          builder: (context, fullViewState) {
                            return FadeSwitcher(
                              child: () {
                                if (fullViewState.isImageFullView) {
                                  return ImageFullViewWidget(
                                    images: state.product.images,
                                    initialIndex: fullViewState.currentIndex,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }(),
                            );
                          },
                        ),
                      ],
                    );
                  case const (ProductDetailsError):
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: theme.spacing.inline.xs + MediaQuery.of(context).padding.top,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: theme.spacing.inline.xs,
                          ),
                          child: ClickableWidget(
                            borderRadius: BorderRadius.circular(
                              theme.borders.radius.medium,
                            ),
                            onTap: () {
                              appNavigator.pop();
                            },
                            child: DSIcon(
                              icon: DSIcons.arrowBack,
                              size: DSIconSize.sm,
                              color: theme.colors.neutral.dark.icon,
                            ),
                          ),
                        ),
                        Expanded(
                          child: MainPageErrorWidget(
                            onRetry: () {
                              context.read<ProductDetailsCubit>().getProductDetails(
                                    productId,
                                  );
                            },
                          ),
                        ),
                      ],
                    );
                  default:
                    return const ProductLoadingWidget();
                }
              }(),
            ),
          );
        },
      ),
    );
  }
}
