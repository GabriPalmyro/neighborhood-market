import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/regex/regex.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/cubit/recover_password_cubit.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/cubit/recover_password_state.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({required this.appNavigator, super.key});
  final AppNavigator appNavigator;

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _sendRecoveryCode() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<RecoverPasswordCubit>().sendRecoveryCode(
          _emailController.text,
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
            if (state is RecoverPasswordCodeSent) {
              widget.appNavigator.pushReplacementNamed(
                Routes.recoverPasswordCode,
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
                    'Recover Password',
                    textAlign: TextAlign.center,
                    customStyle: TextStyle(
                      fontSize: tokens.font.size.sm,
                      fontWeight: tokens.font.weight.bold,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  DSText(
                    'Enter your email to recover your password and get back into your account',
                    textAlign: TextAlign.center,
                    customStyle: TextStyle(
                      fontSize: tokens.font.size.xxs,
                      fontWeight: tokens.font.weight.medium,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  TextInputLabelWidget(
                    label: 'Email',
                    hintText: 'Enter Email',
                    tooltip: 'Enter your email',
                    readOnly: state is RecoverPasswordLoading,
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value?.isNotEmpty != true) {
                        return 'Email is required';
                      } else if (!EmailRegEx.email.hasMatch(value!)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                    onSubmitted: (_) {
                      _sendRecoveryCode();
                    },
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  DSButton(
                    label: 'Send',
                    isLoading: state is RecoverPasswordLoading,
                    type: _emailController.text.isEmpty ? DSButtonType.ghost : DSButtonType.primary,
                    size: DSButtonSize.md,
                    onPressed: () {
                      _sendRecoveryCode();
                    },
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  ClickableWidget(
                    borderRadius: BorderRadius.circular(tokens.borders.radius.medium),
                    onTap: () {
                      widget.appNavigator.pushNamedAndRemoveUntil(Routes.login);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: tokens.spacing.inline.xxxs,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DSText(
                            'You already have an account?',
                            customStyle: TextStyle(
                              color: tokens.colors.neutral.dark.pure,
                              fontSize: tokens.font.size.xxs,
                              fontWeight: tokens.font.weight.medium,
                            ),
                          ),
                          SizedBox(width: tokens.spacing.inline.xxs),
                          DSText(
                            'Log In',
                            customStyle: TextStyle(
                              color: tokens.colors.neutral.light.icon,
                              fontSize: tokens.font.size.xxs,
                            ),
                          ),
                        ],
                      ),
                    ),
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
