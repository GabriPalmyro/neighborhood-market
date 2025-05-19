import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComponent extends StatelessWidget {
  const ShimmerComponent({
    required this.width,
    required this.height,
    this.hasBorderRadius = true,
    super.key,
  });
  
  final double width;
  final double height;
  final bool hasBorderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Shimmer.fromColors(
      baseColor: theme.colors.neutral.light.three,
      highlightColor: theme.colors.neutral.light.three.withValues(alpha: 0.6),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: hasBorderRadius ? BorderRadius.circular(
            theme.borders.radius.medium,
          ) : null,
          color: theme.colors.neutral.dark.three,
        ),
      ),
    );
  }
}
