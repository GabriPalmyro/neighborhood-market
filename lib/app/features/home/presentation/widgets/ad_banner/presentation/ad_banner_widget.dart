import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/domain/model/ad_banner_model.dart';

class AdBannerWidget extends StatelessWidget {
  const AdBannerWidget({
    required this.model,
    required this.appNavigator,
    super.key,
  });

  final AdBannerModel model;
  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    const bannerHeight = 130.0;

    return ClickableWidget(
      borderRadius: BorderRadius.zero,
      onTap: () => appNavigator.pushToUrl(Uri.parse(model.redirectUrl!)),
      child: Ink(
        height: bannerHeight,
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: model.imageUrl,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 250),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              color: tokens.colors.neutral.dark.pure.withValues(alpha: 0.2),
            ),
            padding: EdgeInsets.symmetric(
              vertical: tokens.spacing.inline.lg,
            ),
          ),
        ),
      ),
    );
  }
}
