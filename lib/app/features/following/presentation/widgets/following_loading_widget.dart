import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';

class FollowingLoadingWidget extends StatelessWidget {
  const FollowingLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 70.0;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ).copyWith(
        top: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: ShimmerComponent(
              width: double.infinity,
              height: height,
            ),
          ),
          childCount: 10,
        ),
      ),
    );
  }
}
