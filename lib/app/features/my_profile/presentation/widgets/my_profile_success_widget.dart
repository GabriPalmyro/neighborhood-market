import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/formatter/phone_number_formatter.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/entities/my_profile_entity.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/account_management/deactivate_account_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/account_management/delete_account_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/header_profile/header_my_profile_success.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/update_button/update_button_widget.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/update_email/update_email_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/update_password/update_password_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/update_phone/update_phone_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/my_profile/utils/my_profile_strings.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/model/header_model.dart';

class MyProfileSuccessWidget extends StatefulWidget {
  const MyProfileSuccessWidget({
    required this.entity,
    required this.fullNameController,
    required this.usernameController,
    required this.emailController,
    required this.phoneController,
    required this.biographyController,
    super.key,
  });

  final MyProfileEntity entity;
  final TextEditingController fullNameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController biographyController;

  @override
  State<MyProfileSuccessWidget> createState() => _MyProfileSuccessWidgetState();
}

class _MyProfileSuccessWidgetState extends State<MyProfileSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderMyProfileSuccessWidget(
            model: HeaderModel(
              imageProfile: widget.entity.image,
              imageBackground: widget.entity.background,
              username: widget.entity.username,
              description: widget.entity.biography,
            ),
          ),
          SizedBox(height: theme.spacing.inline.xxs),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.xs,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DSText(
                  MyProfileStrings.title,
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xs,
                    fontWeight: theme.font.weight.semiBold,
                    color: theme.colors.neutral.dark.one,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxxs),
                DSText(
                  MyProfileStrings.subtitle,
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    color: theme.colors.neutral.dark.icon,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xs),
                TextInputLabelWidget(
                  label: 'Full Name',
                  hintText: 'Enter...',
                  tooltip: 'Enter your full name',
                  controller: widget.fullNameController,
                ),
                SizedBox(height: theme.spacing.inline.xs),
                TextInputLabelWidget(
                  label: 'Username',
                  hintText: 'Enter...',
                  tooltip: 'Enter your username',
                  controller: widget.usernameController,
                ),
                SizedBox(height: theme.spacing.inline.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextInputLabelWidget(
                        label: 'Email',
                        hintText: 'Enter...',
                        tooltip: 'Enter your email',
                        readOnly: true,
                        controller: widget.emailController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: theme.spacing.inline.xxs),
                      child: UpdateButtonWidget(
                        onPressed: () {
                          showDSBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            child: const UpdateEmailBottomSheet(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.inline.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextInputLabelWidget(
                        label: 'Phone',
                        hintText: 'Enter...',
                        tooltip: 'Enter your phone',
                        readOnly: true,
                        controller: widget.phoneController,
                        formatter: phoneWithCountryCodeFormatter,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: theme.spacing.inline.xxs),
                      child: UpdateButtonWidget(
                        onPressed: () {
                          showDSBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            child: const UpdatePhoneBottomSheet(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.inline.xs),
                TextInputLabelWidget(
                  label: 'Biography',
                  hintText: 'Enter a detailed description of the your profile',
                  tooltip: 'Enter a detailed description of the your profile',
                  controller: widget.biographyController,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                ),
                SizedBox(height: theme.spacing.inline.xs),
                const ThemeDividerWidget(),
                SizedBox(height: theme.spacing.inline.xs),
                DSText(
                  'Change Password',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xs,
                    fontWeight: theme.font.weight.semiBold,
                    color: theme.colors.neutral.dark.one,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxxs),
                DSText(
                  'Click the button below to update your password for enhanced security.',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    color: theme.colors.neutral.dark.icon,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxs),
                DSButton(
                  label: 'Update Password',
                  onPressed: () {
                    showDSBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      child: const UpdatePasswordBottomSheet(),
                    );
                  },
                  type: DSButtonType.primaryOutline,
                ),
                SizedBox(height: theme.spacing.inline.sm),
                DSText(
                  'Account Management',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xs,
                    fontWeight: theme.font.weight.semiBold,
                    color: theme.colors.neutral.dark.one,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxxs),
                DSText(
                  'Please choose an option below if you wish to deactivate or permanently delete your account.',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    color: theme.colors.neutral.dark.icon,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxs),
                Row(
                  children: [
                    Expanded(
                      child: DSButton(
                        label: 'Deactivate Account',
                        onPressed: () {
                          showDSBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            child: const DeactivateAccountBottomSheet(),
                          );
                        },
                        type: DSButtonType.warningOutline,
                      ),
                    ),
                    SizedBox(width: theme.spacing.inline.xs),
                    Expanded(
                      child: DSButton(
                        label: 'Delete Account',
                        onPressed: () {
                          showDSBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            child: const DeleteAccountBottomSheet(),
                          );
                        },
                        type: DSButtonType.warning,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.inline.xxl + theme.spacing.inline.md),
                SizedBox(height: Platform.isIOS ? MediaQuery.of(context).padding.bottom : 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
