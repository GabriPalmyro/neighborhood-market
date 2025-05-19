import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class MyProfileLoadingWidget extends StatelessWidget {
  const MyProfileLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerComponent(
            width: double.infinity,
            height: 160.0,
            hasBorderRadius: false,
          ),
          SizedBox(height: tokens.spacing.inline.xs),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.inline.xs,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerComponent(
                  width: 40.0,
                  height: 20.0,
                ),
                SizedBox(height: tokens.spacing.inline.xxxs),
                const ShimmerComponent(
                  width: 100.0,
                  height: 35.0,
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                const ShimmerComponent(
                  width: double.infinity,
                  height: 90.0,
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                const ShimmerComponent(
                  width: double.infinity,
                  height: 90.0,
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                const ShimmerComponent(
                  width: double.infinity,
                  height: 90.0,
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                const ShimmerComponent(
                  width: double.infinity,
                  height: 90.0,
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                const ShimmerComponent(
                  width: double.infinity,
                  height: 90.0,
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                const ShimmerComponent(
                  width: double.infinity,
                  height: 90.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
