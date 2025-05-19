import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/following/domain/entities/following_entity.dart';

class FollowingListSuccessWidget extends StatelessWidget {
  const FollowingListSuccessWidget({
    required this.followings,
    super.key,
  });

  final List<FollowingEntity> followings;

  @override
  Widget build(BuildContext context) {
    const imageHeight = 60.0;
    const componentHeight = imageHeight + 25.0;
    final tokens = DSTheme.getDesignTokensOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: tokens.spacing.inline.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DSText(
                'Following',
                customStyle: TextStyle(
                  fontWeight: tokens.font.weight.semiBold,
                  fontSize: tokens.font.size.xs,
                ),
              ),
              ClickableWidget(
                borderRadius: BorderRadius.circular(tokens.borders.radius.small),
                onTap: () {
                  GetIt.I.get<AppNavigator>().pushRoute(Routes.following);
                },
                child: DSText(
                  'See All',
                  customStyle: TextStyle(
                    fontWeight: tokens.font.weight.semiBold,
                    fontSize: tokens.font.size.xs,
                    color: tokens.colors.neutral.light.icon,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: tokens.spacing.inline.xs),
        SizedBox(
          height: componentHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: followings.length > 10 ? 10 : followings.length,
            itemBuilder: (context, index) {
              final item = followings[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? tokens.spacing.inline.xxs : 0,
                  right: index == followings.length - 1 ? tokens.spacing.inline.xxs : 0,
                ),
                child: ClickableWidget(
                  borderRadius: BorderRadius.circular(tokens.borders.radius.small),
                  onTap: () {
                    GetIt.I.get<AppNavigator>().pushRoute(
                      Routes.sellerProfile,
                      queryParameters: {
                        'sellerId': item.id,
                        'sellerName': item.username,
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: tokens.spacing.inline.xs,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: imageHeight,
                          width: imageHeight,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: tokens.colors.neutral.dark.pure.withValues(alpha: .25),
                                blurRadius: 4,
                                offset: const Offset(0, 1.5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(tokens.borders.radius.circular),
                            child: CachedNetworkImage(
                              imageUrl: item.photo,
                              fit: BoxFit.cover,
                              height: imageHeight,
                              placeholder: (context, url) => const Center(
                                child: ShimmerComponent(
                                  width: double.infinity,
                                  height: imageHeight,
                                  hasBorderRadius: false,
                                ),
                              ),
                              errorWidget: (context, url, error) => SizedBox(
                                height: imageHeight,
                                width: imageHeight,
                                child: CircleAvatar(
                                  backgroundColor: tokens.colors.neutral.dark.icon,
                                  child: const DSIcon(
                                    icon: DSIcons.tag,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: tokens.spacing.inline.xxxs),
                        DSText(
                          '@${item.username}',
                          customStyle: TextStyle(
                            fontSize: tokens.font.size.xxxs,
                            fontWeight: tokens.font.weight.medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
