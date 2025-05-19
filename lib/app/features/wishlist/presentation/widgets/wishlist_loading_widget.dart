import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class WishlistLoadingWidget extends StatelessWidget {
  const WishlistLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.inline.xs,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? theme.spacing.stack.xxs : 0,
              bottom: theme.spacing.stack.xxs,
            ),
            child: const ShimmerComponent(
              width: double.infinity,
              height: 105,
            ),
          );
        },
      ),
    );
  }
}
