import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/Profile/presentation/cubit/Profile_state.dart';
import 'package:neighborhood_market/app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/followings/presentation/widgets/following_list_widget.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/model/header_model.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/presentation/widgets/header_profile_success.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/profile_actions/domain/model/profile_actions_model.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/profile_actions/presentation/widgets/profile_action_section_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.appNavigator,
    super.key,
  });

  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String? name;
        String? id;

        if (state is ProfileLoaded) {
          name = state.name;
          id = state.id;
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              FadeSwitcher(
                child: () {
                  if (state is ProfileLoaded) {
                    return HeaderProfileSuccessWidget(
                      model: HeaderModel(
                        username: state.name,
                        description: state.description,
                        imageProfile: state.image,
                        imageBackground: state.background,
                      ),
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).padding.top + 10.0,
                  );
                }(),
              ),
              const FollowingListWidget(),
              SizedBox(height: theme.spacing.inline.xs),
              ProfileActionsSectionsWidget(
                appNavigator: appNavigator,
                model: ProfileActionsSectionsModel(
                  title: 'Account',
                  items: [
                    const ProfileActionsItemsModel(
                      title: 'Settings',
                      route: Routes.myProfile,
                    ),
                    ProfileActionsItemsModel(
                      title: 'Profile',
                      route: Routes.sellerProfile,
                      params: {
                        'sellerId': id ?? '',
                        'sellerName': name ?? '',
                      },
                    ),
                    const ProfileActionsItemsModel(
                      title: 'Notifications',
                      route: Routes.notifications,
                    ),
                  ],
                ),
              ),
              SizedBox(height: theme.spacing.inline.xs),
              ProfileActionsSectionsWidget(
                appNavigator: appNavigator,
                model: const ProfileActionsSectionsModel(
                  title: 'My Closet',
                  items: [
                    ProfileActionsItemsModel(
                      title: 'My Listings',
                      route: Routes.myListing,
                    ),
                    ProfileActionsItemsModel(
                      title: 'My Purchases',
                      route: Routes.myPurchases,
                    ),
                  ],
                ),
              ),
              // SizedBox(height: theme.spacing.inline.xs),
              // ProfileActionsSectionsWidget(
              //   appNavigator: appNavigator,
              //   model: const ProfileActionsSectionsModel(
              //     title: 'Payments',
              //     items: [
              //       ProfileActionsItemsModel(
              //         title: 'Manage Cards',
              //         route: Routes.manageCards,
              //       ),
              //       // ProfileActionsItemsModel(
              //       //   title: 'Purchasing Setup',
              //       //   route: Routes.purchasingSetup,
              //       // ),
              //     ],
              //   ),
              // ),
              SizedBox(height: theme.spacing.inline.xs),
              ProfileActionsSectionsWidget(
                appNavigator: appNavigator,
                model: const ProfileActionsSectionsModel(
                  title: 'Support',
                  items: [
                    ProfileActionsItemsModel(title: 'Help Center'),
                    ProfileActionsItemsModel(title: 'Terms of Use'),
                    ProfileActionsItemsModel(title: 'Privacy Policy'),
                    ProfileActionsItemsModel(
                      title: 'Log out',
                      isLogout: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: theme.spacing.inline.sm),
            ],
          ),
        );
      },
    );
  }
}
