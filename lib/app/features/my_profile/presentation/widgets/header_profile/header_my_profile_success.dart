import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/my_profile_cubit.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/update_profile_photo/update_profile_photo_cubit.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/header_profile/update_background_modal.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/header_profile/update_profile_picture_modal.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/model/header_model.dart';

class HeaderMyProfileSuccessWidget extends StatelessWidget {
  const HeaderMyProfileSuccessWidget({
    required this.model,
    super.key,
  });

  final HeaderModel model;

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
              ClickableWidget(
                borderRadius: BorderRadius.zero,
                onTap: () {
                  showDSBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    child: BlocProvider(
                      create: (context) => GetIt.I.get<UpdateProfilePhotoCubit>(),
                      child: UpdateBackgroundModal(
                        onImageChanged: (newPath) {
                          context.read<MyProfileCubit>().updateBackgroundPicture(newPath);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
                child: Stack(
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
                      bottom: 10,
                      right: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.colors.neutral.light.pure,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            theme.spacing.inline.xxxs,
                          ),
                          child: DSIcon(
                            icon: DSIcons.edit,
                            color: theme.colors.neutral.dark.two,
                            size: DSIconSize.sm,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: profileImagePadding,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDSBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            child: BlocProvider(
                              create: (context) => GetIt.I.get<UpdateProfilePhotoCubit>(),
                              child: UpdateProfilePictureModal(
                                onImageChanged: (newPath) {
                                  context.read<MyProfileCubit>().updateProfilePicture(newPath);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: profileImageSize,
                          width: profileImageSize,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              model.imageProfile?.isNotEmpty == true
                                  ? ClipRRect(
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
                                    )
                                  : CircleAvatar(
                                      backgroundColor: theme.colors.neutral.dark.two,
                                      child: const DSIcon(
                                        icon: DSIcons.tag,
                                      ),
                                    ),
                              Center(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: theme.colors.neutral.light.pure.withValues(alpha: .7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      theme.spacing.inline.xxxs,
                                    ),
                                    child: DSIcon(
                                      icon: DSIcons.edit,
                                      color: theme.colors.neutral.light.icon,
                                      size: DSIconSize.sm,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colors.neutral.light.pure,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        theme.spacing.inline.xxs,
                      ),
                      child: DSIcon(
                        icon: DSIcons.arrowBack,
                        color: theme.colors.neutral.dark.two,
                        size: DSIconSize.xs,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: theme.spacing.inline.xxs),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.inline.lg,
          ),
          child: DSText(
            model.description ?? '',
            maxLines: 3,
            textAlign: TextAlign.center,
            customStyle: TextStyle(
              color: theme.colors.neutral.dark.two,
              fontSize: theme.font.size.xxxs,
            ),
          ),
        ),
        SizedBox(height: theme.spacing.inline.xxs),
      ],
    );
  }
}
