import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class FollowingListLoadingWidget extends StatelessWidget {
  const FollowingListLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    const height = 90.0;
    return Padding(
      padding: EdgeInsets.only(
        top: theme.spacing.inline.xs,
      ),
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.inline.xs,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerComponent(width: 70, height: 20),
                  ShimmerComponent(width: 50, height: 20),
                ],
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (_, __) => Padding(
                  padding: EdgeInsets.only(left: theme.spacing.inline.xs),
                  child: const ShimmerComponent(
                    height: 55,
                    width: 70,
                    hasBorderRadius: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
