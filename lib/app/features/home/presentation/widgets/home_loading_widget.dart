import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/presentation/widgets/shop_gallery_loading_widget.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.xs,
            ).copyWith(
              top: theme.spacing.stack.xs,
            ),
            child: const ShimmerComponent(
              width: double.infinity,
              height: 60,
            ),
          ),
          SizedBox(height: theme.spacing.stack.xs),
          const ShimmerComponent(
            width: double.infinity,
            height: 130,
            hasBorderRadius: false,
          ),
          SizedBox(height: theme.spacing.stack.xs),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.xs,
            ),
            child: const ShopGalleryLoadingWidget(),
          ),
          SizedBox(height: theme.spacing.stack.xs),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.xs,
            ),
            child: const ShopGalleryLoadingWidget(),
          ),
          SizedBox(height: theme.spacing.stack.xs),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.xs,
            ),
            child: const ShopGalleryLoadingWidget(),
          ),
          SizedBox(height: theme.spacing.stack.xs),
        ],
      ),
    );
  }
}
