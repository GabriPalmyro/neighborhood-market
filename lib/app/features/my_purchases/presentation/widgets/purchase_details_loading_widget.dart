import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class PurchaseDetailsLoadingWidget extends StatelessWidget {
  const PurchaseDetailsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.inline.xs,
        vertical: theme.spacing.inline.xs,
      ),
      child:  Column(
        children: [
          const ShimmerComponent(
            width: double.infinity,
            height: 300,
          ),
          SizedBox(height: theme.spacing.inline.sm),
          const ShimmerComponent(
            width: double.infinity,
            height: 250,
          ),
        ],
      ),
    );
  }
}
