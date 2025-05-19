import 'package:flutter/material.dart' hide WidgetState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/badge/badge_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/common/extensions/string_extension.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/core/core.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/presentation/widgets/shop_gallery_success_widget.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/action_button_type.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/product_entity.dart';
import 'package:neighborhood_market/app/features/product/presentation/cubit/product_details_cubit.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/image_carousel/presentation/image_carousel_success_widget.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/product_action_button_widget.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_description/presentation/product_description_success.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_header/presentation/product_header_widget.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_seller/presentation/product_seller_success_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

class ProductSuccessWidget extends StatefulWidget {
  const ProductSuccessWidget({
    required this.product,
    required this.appNavigator,
    this.showShareButton = false,
    super.key,
  });

  final ProductEntity product;
  final AppNavigator appNavigator;
  final bool showShareButton;

  @override
  State<ProductSuccessWidget> createState() => _ProductSuccessWidgetState();
}

class _ProductSuccessWidgetState extends State<ProductSuccessWidget> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future<void> _shareProduct() async {
    // Define the deep link
    final deepLink = await context.read<ProductDetailsCubit>().generateShareProductLink(
          widget.product.id,
        );

    // Share the deep link
    SharePlus.instance.share(
      ShareParams(
        text: 'Check out this product: $deepLink',
        subject: AppStrings.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      children: [
        Expanded(
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              context.read<ProductDetailsCubit>().getProductDetails(
                    widget.product.id,
                  );
              _refreshController.refreshCompleted();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: TopbarWidget.defaultTopBar(
                    actions: [
                      ClickableWidget(
                        borderRadius: BorderRadius.circular(
                          theme.borders.radius.medium,
                        ),
                        onTap: () {
                          if (context.read<ProductDetailsCubit>().state is ProductDetailsLoading) {
                            return;
                          }

                          context.read<ProductDetailsCubit>().changeLikeStatus(
                            onSuccess: (isLiked) {
                              ScaffoldMessenger.of(context).showSuccessSnackBar(
                                context,
                                content: isLiked ? 'Added to wishlist' : 'Removed from wishlist',
                              );
                            },
                            onError: () {
                              ScaffoldMessenger.of(context).showErrorSnackBar(
                                context,
                                content: 'There was an error while adding to favorites',
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(theme.spacing.stack.xxs),
                          child: DSIcon(
                            icon: DSIcons.heartFilled,
                            size: DSIconSize.md,
                            color: widget.product.isLiked ? theme.colors.feedback.error : theme.colors.neutral.dark.three,
                          ),
                        ),
                      ),
                      SizedBox(width: theme.spacing.inline.xxs),
                      if (widget.showShareButton) ...[
                        ClickableWidget(
                          borderRadius: BorderRadius.circular(
                            theme.borders.radius.medium,
                          ),
                          onTap: _shareProduct,
                          child: Padding(
                            padding: EdgeInsets.all(theme.spacing.stack.xxs),
                            child: DSIcon(
                              icon: DSIcons.share,
                              size: DSIconSize.md,
                              color: theme.colors.neutral.dark.three,
                            ),
                          ),
                        ),
                        SizedBox(width: theme.spacing.inline.xxs),
                      ],
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: ImageCarouselSuccessWidget(
                    images: widget.product.images,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing.inline.xs,
                    vertical: theme.spacing.inline.xs,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductHeaderWidget(
                          label: widget.product.title,
                          price: widget.product.price.toCurrency(),
                        ),
                        SizedBox(height: theme.spacing.inline.xs),
                        const ThemeDividerWidget(),
                        SizedBox(height: theme.spacing.inline.xxs),
                        ProductDescriptionSuccess(
                          description: widget.product.description,
                        ),
                        SizedBox(height: theme.spacing.inline.xxs),
                        Wrap(
                          spacing: theme.spacing.inline.xxs,
                          runSpacing: theme.spacing.inline.xxs,
                          children: widget.product.tags
                              .map(
                                (badge) => BadgeWidget(
                                  label: badge.capitalize(),
                                  size: BadgeSize.medium,
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(height: theme.spacing.inline.xs),
                        const ThemeDividerWidget(),
                        SizedBox(height: theme.spacing.inline.xs),
                        if (widget.product.brand?.isNotEmpty == true) ...[
                          ItemLabelDescriptionWidget(
                            label: 'Brand',
                            value: widget.product.brand!,
                          ),
                        ],
                        if (widget.product.tailoredDetails?.isNotEmpty == true) ...[
                          ItemLabelDescriptionWidget(
                            label: 'Details',
                            value: widget.product.tailoredDetails!,
                          ),
                        ],
                        if (widget.product.flaws?.isNotEmpty == true) ...[
                          ItemLabelDescriptionWidget(
                            label: 'Flaws',
                            value: widget.product.flaws!,
                          ),
                        ],
                        if (widget.product.size?.isNotEmpty == true) ...[
                          ItemLabelDescriptionWidget(
                            label: 'Size',
                            value: widget.product.size!,
                          ),
                        ],
                        if (widget.product.gender?.isNotEmpty == true) ...[
                          ItemLabelDescriptionWidget(
                            label: 'Gender',
                            value: widget.product.gender!.capitalize(),
                          ),
                        ],
                        SizedBox(height: theme.spacing.inline.xs),
                        if (widget.product.recommended != null && widget.product.recommended!.items.isNotEmpty) ...[
                          ShopGallerySuccessWidget(
                            model: widget.product.recommended!,
                            navigator: GetIt.I<AppNavigator>(),
                          ),
                          SizedBox(height: theme.spacing.inline.xs),
                          const ThemeDividerWidget(),
                          SizedBox(height: theme.spacing.inline.xs),
                        ],
                        if (widget.product.seller != null) ...{
                          ProductSellerSuccessWidget(
                            seller: widget.product.seller!,
                            appNavigator: GetIt.I<AppNavigator>(),
                          ),
                          SizedBox(height: theme.spacing.inline.xs),
                        },
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.product.actionType != null && widget.product.actionType! != ActionButtonType.unknown) ...{
          ProductActionButtonWidget(
            productId: widget.product.id,
            actionType: widget.product.actionType!,
            appNavigator: widget.appNavigator,
          ),
        },
      ],
    );
  }
}

class ItemLabelDescriptionWidget extends StatelessWidget {
  const ItemLabelDescriptionWidget({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSText(
              label,
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.pure,
                fontSize: theme.font.size.xs,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            DSText(value),
          ],
        ),
        SizedBox(height: theme.spacing.inline.xxs),
        const ThemeDividerWidget(),
        SizedBox(height: theme.spacing.inline.xxs),
      ],
    );
  }
}
