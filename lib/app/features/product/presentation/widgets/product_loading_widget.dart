import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/presentation/widgets/shop_gallery_loading_widget.dart';

class ProductLoadingWidget extends StatelessWidget {
  const ProductLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + theme.spacing.inline.xs),
          Padding(
            padding: EdgeInsets.only(
              left: theme.spacing.inline.xs,
            ),
            child: ClickableWidget(
              borderRadius: BorderRadius.circular(
                theme.borders.radius.medium,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: DSIcon(
                icon: DSIcons.arrowBack,
                size: DSIconSize.sm,
                color: theme.colors.neutral.dark.icon,
              ),
            ),
          ),
          SizedBox(
            height: theme.spacing.inline.xs,
          ),
          const ShimmerComponent(
            width: double.infinity,
            hasBorderRadius: false,
            height: 350,
          ),
          SizedBox(height: theme.spacing.stack.xs),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.stack.xxs,
            ),
            child: const ShimmerComponent(
              width: double.infinity,
              height: 80,
            ),
          ),
          SizedBox(height: theme.spacing.stack.xs),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.stack.xxs,
            ),
            child: const ShimmerComponent(
              width: double.infinity,
              height: 150,
            ),
          ),
          SizedBox(height: theme.spacing.stack.xs),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.stack.xxs,
            ),
            child: const ShopGalleryLoadingWidget(),
          ),
          SizedBox(height: theme.spacing.stack.xs),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.stack.xxs,
            ),
            child: const ShimmerComponent(
              width: double.infinity,
              height: 150,
            ),
          ),
          SizedBox(height: theme.spacing.stack.sm),
        ],
      ),
    );
  }
}
