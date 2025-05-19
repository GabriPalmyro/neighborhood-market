import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/regex/regex.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:neighborhood_market/app/features/login/presentation/cubit/login_state.dart';
import 'package:neighborhood_market/app/features/login/presentation/widgets/reactivate_account_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/login/utils/errors/login_errors.dart';
import 'package:neighborhood_market/app/features/login/utils/login_strings.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/eye_control_cubit.dart';
import 'package:neighborhood_market/app/utils/errors/exceptions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    required this.appNavigator,
    super.key,
  });
  final AppNavigator appNavigator;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goToMain() {
    widget.appNavigator.pushReplacementNamed(Routes.main);
  }

  void _goToRegister() {
    widget.appNavigator.pushRoute(
      Routes.register,
      queryParameters: {'page': '3'},
    );
  }

  void _goToAppPayment() {
    widget.appNavigator.pushRoute(Routes.registerPayment);
  }

  void _showReactiveBottomSheet() {
    showDSBottomSheet(
      context: context,
      isScrollControlled: false,
      child: const ReactivateAccountBottomSheet(),
    );
  }

  void _showErrorMessage(String message) {
    showDSBottomSheet(
      context: context,
      isScrollControlled: false,
      child: ErrorBottomSheetWidget(
        message: message,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      backgroundColor: tokens.colors.neutral.light.background,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            _goToMain();
          } else if (state is LoginFailure) {
            if (state.exception is UserNotValidated) {
              _goToRegister();
            } else if (state.exception is PaymentRequired) {
              _goToAppPayment();
            } else if (state.exception is AccountDeactivated) {
              _showReactiveBottomSheet();
            } else if (state.exception is BadRequestException) {
              final message = (state.exception as BadRequestException).message;
              _showErrorMessage(message);
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.inline.sm,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ThemeImage(
                    ThemeImages.logo,
                    color: tokens.colors.neutral.dark.pure,
                    size: Size(
                      MediaQuery.of(context).size.width * 0.3,
                      80,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  DSText(
                    LoginStrings.loginDescription,
                    textAlign: TextAlign.center,
                    customStyle: TextStyle(
                      color: tokens.colors.neutral.dark.pure,
                      fontSize: tokens.font.size.xxs,
                      fontWeight: tokens.font.weight.regular,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.md),
                  TextInputLabelWidget(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    textCapitalization: TextCapitalization.none,
                    label: 'Email',
                    hintText: 'Enter your email',
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      FocusScope.of(context).nextFocus();
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (!EmailRegEx.email.hasMatch(value ?? '')) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  BlocBuilder<EyeControlCubit, bool>(
                    builder: (context, state) {
                      return TextInputLabelWidget(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.password],
                        textCapitalization: TextCapitalization.none,
                        onChanged: (_) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        label: 'Password',
                        hintText: 'Enter Password',
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
                      );
                    },
                  ),
                  SizedBox(height: tokens.spacing.inline.xxxs),
                  GestureDetector(
                    onTap: () {
                      widget.appNavigator.pushRoute(Routes.recoverPassword);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: tokens.spacing.inline.xxs,
                      ),
                      child: DSText(
                        'Forgot Password?',
                        textAlign: TextAlign.start,
                        customStyle: TextStyle(
                          color: tokens.colors.neutral.dark.icon,
                          fontSize: tokens.font.size.xxxs,
                          fontWeight: tokens.font.weight.medium,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.sm),
                  DSButton(
                    label: 'Continue',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        TextInput.finishAutofillContext();
                        context.read<LoginCubit>().login(
                              _emailController.text,
                              _passwordController.text,
                            );
                      }
                    },
                    size: DSButtonSize.md,
                    isLoading: state is LoginLoading,
                    type: _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty ? DSButtonType.secondary : DSButtonType.ghost,
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  ClickableWidget(
                    borderRadius: BorderRadius.circular(tokens.borders.radius.medium),
                    onTap: () {
                      widget.appNavigator.pushRoute(Routes.register);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: tokens.spacing.inline.xxxs,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DSText(
                            'Don\'t have an account?',
                            customStyle: TextStyle(
                              color: tokens.colors.neutral.dark.pure,
                              fontSize: tokens.font.size.xxs,
                              fontWeight: tokens.font.weight.medium,
                            ),
                          ),
                          SizedBox(width: tokens.spacing.inline.xxs),
                          DSText(
                            'Sign up',
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
            ),
          );
        },
      ),
    );
  }
}
