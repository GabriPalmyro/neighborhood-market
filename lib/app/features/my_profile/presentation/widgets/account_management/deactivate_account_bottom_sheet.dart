// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/account_management/account_management_cubit.dart';
import 'package:neighborhood_market/app/features/profile/presentation/cubit/profile_cubit.dart';

class DeactivateAccountBottomSheet extends StatelessWidget {
  const DeactivateAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (context) => GetIt.I<AccountManagementCubit>(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          theme.spacing.inline.xs,
          theme.spacing.inline.lg,
          theme.spacing.inline.xs,
          MediaQuery.of(context).viewInsets.bottom + theme.spacing.inline.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSText(
              'Deactivate Account',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              'Are you sure you want to deactivate your account?',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.regular,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            DSText(
              'Deactivating your account will temporarily disable access and hide your profile and data from other users. You can reactivate it anytime by logging back in.',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxxs,
                color: theme.colors.neutral.dark.two,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            BlocConsumer<AccountManagementCubit, AccountManagementState>(
              listener: (context, state) async {
                if (state is AccountDeactivateSuccess) {
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSuccessSnackBar(
                    context,
                    content: 'Account deactivated successfully',
                  );

                  context.read<ProfileCubit>().logout();
                  GetIt.I.get<AppNavigator>().pushNamedAndRemoveUntil(Routes.login);
                } else if (state is AccountManagementError) {
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showErrorSnackBar(
                    context,
                    content: state.message,
                  );
                }
              },
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: DSButton(
                        label: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        type: DSButtonType.ghost,
                      ),
                    ),
                    SizedBox(width: theme.spacing.inline.xs),
                    Expanded(
                      child: DSButton(
                        label: 'Confirm',
                        type: DSButtonType.warning,
                        isLoading: state is AccountManagementLoading,
                        onPressed: () {
                          context.read<AccountManagementCubit>().deactivateAccount();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: theme.spacing.inline.sm),
          ],
        ),
      ),
    );
  }
}
