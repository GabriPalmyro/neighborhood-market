import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';

class ShopGalleryLoadingWidget extends StatelessWidget {
  const ShopGalleryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerComponent(
              width: 150,
              height: 25,
            ),
            ShimmerComponent(
              width: 100,
              height: 25,
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ShimmerComponent(
                width: double.infinity,
                height: 160,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ShimmerComponent(
                width: double.infinity,
                height: 160,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
