import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/card/card_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/profile_actions/domain/model/profile_actions_model.dart';

class ProfileActionsSectionsWidget extends StatelessWidget {
  const ProfileActionsSectionsWidget({
    required this.appNavigator,
    required this.model,
    super.key,
  });

  final AppNavigator appNavigator;
  final ProfileActionsSectionsModel model;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: tokens.spacing.inline.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DSText(
            model.title,
            customStyle: TextStyle(
              fontSize: tokens.font.size.xs,
              fontWeight: tokens.font.weight.medium,
            ),
          ),
          SizedBox(height: tokens.spacing.inline.xxs),
          ThemeCardWidget(
            borderRadius: BorderRadius.circular(tokens.borders.radius.extraLarge),
            child: Column(
              children: List.generate(
                model.items.length,
                (index) {
                  final item = model.items[index];
                  return Column(
                    children: [
                      ClickableWidget(
                        borderRadius: index == 0
                            ? BorderRadius.only(
                                topLeft: Radius.circular(tokens.borders.radius.extraLarge),
                                topRight: Radius.circular(tokens.borders.radius.extraLarge),
                              )
                            : index == model.items.length - 1
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(tokens.borders.radius.extraLarge),
                                    bottomRight: Radius.circular(tokens.borders.radius.extraLarge),
                                  )
                                : BorderRadius.zero,
                        onTap: () async {
                          if (item.isLogout) {
                            await context.read<ProfileCubit>().logout();
                            appNavigator.pushNamedAndRemoveUntil(Routes.login);
                          }
                          if (item.route != null) {
                            appNavigator.pushRoute(
                              item.route!,
                              queryParameters: item.params,
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: tokens.spacing.inline.xs,
                            vertical: tokens.spacing.inline.xxs + 6,
                          ),
                          child: Row(
                            children: [
                              DSText(
                                item.title,
                                customStyle: TextStyle(
                                  color: item.isLogout ? tokens.colors.feedback.error : tokens.colors.neutral.dark.pure,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.chevron_right_outlined,
                                color: tokens.colors.neutral.dark.two,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (index != model.items.length - 1) const ThemeDividerWidget(),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
