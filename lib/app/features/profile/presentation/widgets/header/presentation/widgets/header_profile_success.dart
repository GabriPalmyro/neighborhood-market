import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/badge/badge_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/following/utils/following_strings.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/model/header_model.dart';

class HeaderProfileSuccessWidget extends StatelessWidget {
  const HeaderProfileSuccessWidget({
    required this.model,
    this.id,
    this.onFollow,
    super.key,
  });

  final HeaderModel model;
  final String? id;
  final Function(bool, String)? onFollow;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    const profileImageSize = 78.0;
    const backgroundImageSize = 128.0;
    const profileImagePadding = 85.0;
    const contentHeight = backgroundImageSize + 60.0;
    return Column(
      children: [
        SizedBox(
          height: contentHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              model.imageBackground?.isNotEmpty == true
                  ? CachedNetworkImage(
                      imageUrl: model.imageBackground!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: backgroundImageSize,
                      errorWidget: (_, __, ___) => const ThemeImage(
                        ThemeImages.profileBackground,
                        fit: BoxFit.fitWidth,
                        size: Size.fromHeight(backgroundImageSize),
                      ),
                    )
                  : const ThemeImage(
                      ThemeImages.profileBackground,
                      fit: BoxFit.cover,
                      size: Size.fromHeight(backgroundImageSize),
                    ),
              Positioned(
                top: profileImagePadding,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (model.imageProfile?.isEmpty == true) ...[
                        SizedBox(
                          height: profileImageSize,
                          width: profileImageSize,
                          child: CircleAvatar(
                            backgroundColor: theme.colors.neutral.dark.icon,
                            child: const DSIcon(
                              icon: DSIcons.tag,
                            ),
                          ),
                        ),
                      ] else ...[
                        SizedBox(
                          height: profileImageSize,
                          width: profileImageSize,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(theme.borders.radius.circular),
                            child: CachedNetworkImage(
                              imageUrl: model.imageProfile ?? '',
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => CircleAvatar(
                                backgroundColor: theme.colors.neutral.dark.icon,
                                child: const DSIcon(
                                  icon: DSIcons.tag,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: theme.spacing.inline.xxxs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DSText(
                            model.username ?? '',
                            customStyle: TextStyle(
                              color: theme.colors.neutral.dark.pure,
                              fontSize: theme.font.size.xs,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: theme.spacing.inline.xxs),
                          DSIcon(
                            icon: DSIcons.check,
                            color: theme.colors.brand.secondary,
                            size: DSIconSize.sm,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: theme.spacing.inline.xxs),
        if (model.isFollowing != null) ...[
          SizedBox(height: theme.spacing.inline.xxxs),
          SelectBadgeWidget(
            size: BadgeSize.small,
            label: model.isFollowing! ? FollowingStrings.unfollow : FollowingStrings.follow,
            onTap: () {
              onFollow?.call(!model.isFollowing!, id ?? '');
            },
            isSelected: model.isFollowing!,
          ),
        ],
        SizedBox(height: theme.spacing.inline.xxs),
        if (model.description?.isNotEmpty == true) ...[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.lg,
            ),
            child: DSText(
              model.description!,
              maxLines: 3,
              textAlign: TextAlign.center,
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.two,
                fontSize: theme.font.size.xxxs,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
