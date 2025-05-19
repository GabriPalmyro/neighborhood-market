import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/regex/regex.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/core/app_consts.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/cubit/recover_password_cubit.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/cubit/recover_password_state.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/eye_control_cubit.dart';

class EnterNewPasswordPage extends StatefulWidget {
  const EnterNewPasswordPage({required this.appNavigator, super.key});
  final AppNavigator appNavigator;

  @override
  State<EnterNewPasswordPage> createState() => _EnterNewPasswordPageState();
}

class _EnterNewPasswordPageState extends State<EnterNewPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmNewPasswordFocus = FocusNode();

  @override
  void dispose() {
    _confirmNewPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _sendRecoveryCode() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<RecoverPasswordCubit>().resetPassword(
          _newPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      backgroundColor: tokens.colors.neutral.light.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.inline.sm,
        ),
        child: BlocConsumer<RecoverPasswordCubit, RecoverPasswordState>(
          listener: (context, state) {
            if (state is RecoverPasswordSuccess) {
              widget.appNavigator.pushReplacementNamed(
                Routes.recoverPasswordSuccess,
                queryParameters: {
                  'email': state.email,
                },
              );
            } else if (state is RecoverPasswordError) {
              showDSBottomSheet(
                context: context,
                isScrollControlled: false,
                child: ErrorBottomSheetWidget(
                  message: state.message,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DSText(
                    'Set a New Password',
                    textAlign: TextAlign.center,
                    customStyle: TextStyle(
                      fontSize: tokens.font.size.sm,
                      fontWeight: tokens.font.weight.bold,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  DSText(
                    'Enter and confirm your new password to reset your account access.',
                    textAlign: TextAlign.center,
                    customStyle: TextStyle(
                      fontSize: tokens.font.size.xxs,
                      fontWeight: tokens.font.weight.medium,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.md),
                  BlocBuilder<EyeControlCubit, bool>(
                    builder: (context, state) {
                      return TextInputLabelWidget(
                        label: 'New password',
                        hintText: 'Enter New Password',
                        tooltip: 'Enter your new password',
                        controller: _newPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.password],
                        textInputAction: TextInputAction.next,
                        focusNode: _newPasswordFocus,
                        obscureText: !state,
                        suffixWidget: IconButton(
                          highlightColor: tokens.colors.neutral.light.one.withValues(alpha: 0.3),
                          onPressed: () {
                            context.read<EyeControlCubit>().changeEyeState();
                          },
                          icon: DSIcon(
                            icon: state ? DSIcons.eyeOpen : DSIcons.eyeClosed,
                            color: tokens.colors.neutral.light.two,
                          ),
                        ),
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
                        onChanged: (_) {
                          setState(() {});
                        },
                        onSubmitted: (_) {
                          FocusScope.of(context).nextFocus();
                        },
                      );
                    },
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  BlocBuilder<EyeControlCubit, bool>(
                    builder: (context, state) {
                      return TextInputLabelWidget(
                        label: 'Confirm password',
                        hintText: 'Enter New Password',
                        tooltip: 'Enter your new password',
                        controller: _confirmNewPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.password],
                        textInputAction: TextInputAction.done,
                        focusNode: _confirmNewPasswordFocus,
                        obscureText: !state,
                        suffixWidget: IconButton(
                          highlightColor: tokens.colors.neutral.light.one.withValues(alpha: 0.3),
                          onPressed: () {
                            context.read<EyeControlCubit>().changeEyeState();
                          },
                          icon: DSIcon(
                            icon: state ? DSIcons.eyeOpen : DSIcons.eyeClosed,
                            color: tokens.colors.neutral.light.two,
                          ),
                        ),
                        validator: (value) {
                          if (_newPasswordController.text != value) {
                            return 'The passwords do not match';
                          }
                          return null;
                        },
                        onChanged: (_) {
                          setState(() {});
                        },
                        onSubmitted: (_) {
                          _sendRecoveryCode();
                        },
                      );
                    },
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  DSButton(
                    label: 'Reset Password',
                    isLoading: state is RecoverPasswordLoading,
                    type: DSButtonType.primary,
                    size: DSButtonSize.md,
                    onPressed: () {
                      _sendRecoveryCode();
                    },
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
