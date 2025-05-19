import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/badge/badge_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/string_extension.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/following/domain/entities/following_entity.dart';
import 'package:neighborhood_market/app/features/following/presentation/cubit/followings_cubit.dart';
import 'package:neighborhood_market/app/features/following/utils/following_strings.dart';

class FollowingCardWidget extends StatelessWidget {
  const FollowingCardWidget({required this.following, super.key});

  final FollowingEntity following;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    const cardHeight = 70.0;
    const imageHeight = 55.0;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.inline.xs,
      ).copyWith(
        top: theme.spacing.inline.xs,
      ),
      child: SizedBox(
        height: cardHeight,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.neutral.light.pure,
            borderRadius: BorderRadius.circular(
              theme.borders.radius.medium,
            ),
            border: Border.all(
              color: theme.colors.neutral.light.three,
              width: theme.borderWidth.thin,
            ),
          ),
          child: ClickableWidget(
            onTap: () {
              GetIt.I.get<AppNavigator>().pushRoute(
                Routes.sellerProfile,
                queryParameters: {
                  'sellerId': following.id,
                  'sellerName': following.username,
                },
              );
            },
            borderRadius: BorderRadius.circular(
              theme.borders.radius.medium,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.inline.xs,
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: imageHeight,
                    width: imageHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        theme.borders.radius.circular,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: following.photo,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => SizedBox(
                          height: imageHeight,
                          width: imageHeight,
                          child: CircleAvatar(
                            backgroundColor: theme.colors.neutral.dark.icon,
                            child: const DSIcon(
                              icon: DSIcons.tag,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: theme.spacing.inline.xs),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DSText(
                              '@${following.username.capitalize()}',
                              customStyle: TextStyle(
                                fontSize: theme.font.size.xs,
                                fontWeight: theme.font.weight.medium,
                              ),
                            ),
                            if (following.isChecked) ...[
                              SizedBox(width: theme.spacing.inline.xxxs),
                              DSIcon(
                                icon: DSIcons.check,
                                color: theme.colors.brand.secondary,
                                size: DSIconSize.sm,
                              ),
                            ],
                          ],
                        ),
                        DSText(
                          '${following.availableItem} items available',
                          customStyle: TextStyle(
                            fontSize: theme.font.size.xxxs,
                            fontWeight: theme.font.weight.medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SelectBadgeWidget(
                    size: BadgeSize.small,
                    label: following.isFollowing ? FollowingStrings.unfollow : FollowingStrings.follow,
                    onTap: () {
                      if(following.isFollowing) {
                        context.read<FollowingsCubit>().unfollowUser(following.id).then((_) {
                          context.read<FollowingsCubit>().emitFollowingUpdateEvent();
                        });
                      } else {
                        context.read<FollowingsCubit>().followUser(following.id).then((_) {
                          context.read<FollowingsCubit>().emitFollowingUpdateEvent();
                        });
                      }
                    },
                    isSelected: following.isFollowing,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
