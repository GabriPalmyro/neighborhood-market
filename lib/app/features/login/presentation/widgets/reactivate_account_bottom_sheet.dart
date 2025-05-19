// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/account_management/account_management_cubit.dart';

class ReactivateAccountBottomSheet extends StatelessWidget {
  const ReactivateAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (context) => GetIt.I<AccountManagementCubit>(),
      child: Builder(
        builder: (context) => PopScope(
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) {
              context.read<AccountManagementCubit>().logout();
            }
          },
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
                  'Reactivate Account',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    fontWeight: theme.font.weight.bold,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxxs),
                DSText(
                  'Are you sure you want to reactivate your account?',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    fontWeight: theme.font.weight.regular,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxs),
                DSText(
                  'Reactivating your account will restore access and make your profile and data visible to other users again. You will need to log in again to access the app.',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxxs,
                    color: theme.colors.neutral.dark.two,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xs),
                BlocConsumer<AccountManagementCubit, AccountManagementState>(
                  listener: (context, state) async {
                    if (state is AccountActivatedSuccess) {
                      context.read<AccountManagementCubit>().logout();
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSuccessSnackBar(
                        context,
                        content: 'Account reactivated successfully, please log in again',
                      );
                    } else if (state is AccountManagementError) {
                      context.read<AccountManagementCubit>().logout();
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showErrorSnackBar(
                        context,
                        content: 'Account could not be reactivated at this time, please try again later',
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
                              context.read<AccountManagementCubit>().logout();
                              Navigator.of(context).pop();
                            },
                            type: DSButtonType.ghost,
                          ),
                        ),
                        SizedBox(width: theme.spacing.inline.xs),
                        Expanded(
                          child: DSButton(
                            label: 'Confirm',
                            type: DSButtonType.secondary,
                            isLoading: state is AccountManagementLoading,
                            onPressed: () {
                              context.read<AccountManagementCubit>().reactivateAccount();
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
        ),
      ),
    );
  }
}
