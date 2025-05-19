import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/regex/regex.dart';
import 'package:neighborhood_market/app/core/app_consts.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/update_password/update_password_cubit.dart';

class UpdatePasswordBottomSheet extends StatefulWidget {
  const UpdatePasswordBottomSheet({super.key});

  @override
  State<UpdatePasswordBottomSheet> createState() => _UpdatePasswordBottomSheetState();
}

class _UpdatePasswordBottomSheetState extends State<UpdatePasswordBottomSheet> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (context) => GetIt.I.get<UpdatePasswordCubit>(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          theme.spacing.inline.xs,
          theme.spacing.inline.xs,
          theme.spacing.inline.xs,
          MediaQuery.of(context).viewInsets.bottom + theme.spacing.inline.xs,
        ),
        child: BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
          listener: (context, state) {
            if (state is UpdatePasswordSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSuccessSnackBar(
                context,
                content: 'Password updated successfully',
              );
            } else if (state is UpdatePasswordFailure) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showErrorSnackBar(
                context,
                content: state.message,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DSText(
                    'Change Password',
                    customStyle: TextStyle(
                      fontSize: theme.font.size.xxs,
                      fontWeight: theme.font.weight.bold,
                    ),
                  ),
                  SizedBox(height: theme.spacing.inline.xxxs),
                  DSText(
                    'Please enter your current password and create a new password to update your account security.',
                    customStyle: TextStyle(
                      fontSize: theme.font.size.xxs,
                      fontWeight: theme.font.weight.regular,
                    ),
                  ),
                  SizedBox(height: theme.spacing.inline.xxs),
                  TextInputLabelWidget(
                    label: 'Enter your current password',
                    hintText: 'Enter',
                    controller: _currentPassword,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.password],
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: theme.spacing.inline.xxs),
                  TextInputLabelWidget(
                    label: 'Create your new password',
                    hintText: 'Enter',
                    controller: _newPassword,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.password],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The password field cannot be empty';
                      } else if (value.length < AppConsts.minPasswordLenght) {
                        return 'The password must be at least ${AppConsts.minPasswordLenght} characters long';
                      } else if (!PasswordRegEx.passwordNoNumber.hasMatch(value)) {
                        return 'The password must contain at least one number';
                      } else if (!PasswordRegEx.passwordNoLetter.hasMatch(value)) {
                        return 'The password must contain at least one letter';
                      } else if (PasswordRegEx.passwordTooSimple.hasMatch(value)) {
                        return 'The password is too simple, try using a mix of numbers and letters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: theme.spacing.inline.xxs),
                  TextInputLabelWidget(
                    label: 'Re-enter your new password',
                    hintText: 'Enter',
                    controller: _confirmNewPassword,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.password],
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please re-enter your new password';
                      }
                      if (value != _newPassword.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: theme.spacing.inline.xxs),
                  DSText(
                    'Ensure your new password is at least 8 characters long, includes a mix of letters and numbers, and is case-sensitive.',
                    customStyle: TextStyle(
                      fontSize: theme.font.size.xxxs,
                      color: theme.colors.neutral.dark.two,
                    ),
                  ),
                  SizedBox(height: theme.spacing.inline.xs),
                  Row(
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
                          label: 'Update Password',
                          isLoading: state is UpdatePasswordLoading,
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              context.read<UpdatePasswordCubit>().updatePassword(
                                    currentPassword: _currentPassword.text,
                                    newPassword: _newPassword.text,
                                  );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: theme.spacing.inline.sm,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
