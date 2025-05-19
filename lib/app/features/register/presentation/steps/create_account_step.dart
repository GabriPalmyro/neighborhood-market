import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/formatter/phone_number_formatter.dart';
import 'package:neighborhood_market/app/common/regex/regex.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/core/app_consts.dart';
import 'package:neighborhood_market/app/features/register/domain/entity/register_steps_enum.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/eye_control_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register/register_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register/register_state.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_cubit.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

class CreateAccountStep extends StatefulWidget {
  const CreateAccountStep({required this.appNavigator, super.key});
  final AppNavigator appNavigator;

  @override
  State<CreateAccountStep> createState() => _CreateAccountStepState();
}

class _CreateAccountStepState extends State<CreateAccountStep> with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _termsAccepted = false;
  bool _isTermsError = false;

  void _toggleTerms() {
    setState(() {
      _isTermsError = false;
      _termsAccepted = !_termsAccepted;
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.inline.xs),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: theme.spacing.inline.sm),
              DSText(
                RegisterStrings.createAccount,
                customStyle: TextStyle(
                  fontSize: theme.font.size.sm,
                  fontWeight: theme.font.weight.semiBold,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xxxs),
              DSText(
                RegisterStrings.createAccountDescription,
                customStyle: TextStyle(
                  fontSize: theme.font.size.xxs,
                  fontWeight: theme.font.weight.regular,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextInputLabelWidget(
                controller: _emailController,
                validator: (value) {
                  if (value?.isNotEmpty != true) {
                    return 'Email is required';
                  } else if (!EmailRegEx.email.hasMatch(value!)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                label: 'Email',
                tooltip: 'Email for login',
                hintText: 'Enter Email',
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextInputLabelWidget(
                controller: _phoneNumberController,
                label: 'Phone Number',
                tooltip: 'Enter...',
                hintText: 'Enter...',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The phone number field cannot be empty';
                  } else if (value.length < AppConsts.maxPhoneNumberCharacters) {
                    return 'The phone number must be at least ${AppConsts.maxPhoneNumberCharacters} characters long';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.telephoneNumber],
                keyboardType: TextInputType.phone,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                formatter: phoneNumberFormatter,
                prefixWidget: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(theme.borders.radius.circular),
                      bottomLeft: Radius.circular(theme.borders.radius.circular),
                    ),
                    border: Border(
                      right: BorderSide(
                        color: theme.colors.neutral.light.three,
                        width: theme.borders.width.thick,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: theme.spacing.inline.xs,
                    right: theme.spacing.inline.xs,
                  ),
                  margin: EdgeInsets.only(
                    right: theme.spacing.inline.xxs,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DSText(
                        RegisterStrings.usaCountryCode,
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xs,
                          color: theme.colors.neutral.dark.one,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: theme.spacing.inline.sm),
              BlocBuilder<EyeControlCubit, bool>(
                builder: (context, state) {
                  return TextInputLabelWidget(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password',
                    hintText: 'Enter Password',
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
                        return 'The password is too simple, try using a mix of numbers and letters and special characters';
                      }
                      return null;
                    },
                    obscureText: !state,
                    suffixWidget: IconButton(
                      highlightColor: theme.colors.neutral.light.one.withValues(alpha: 0.3),
                      onPressed: () {
                        context.read<EyeControlCubit>().changeEyeState();
                      },
                      icon: DSIcon(
                        icon: !state ? DSIcons.eyeClosed : DSIcons.eyeOpen,
                        color: theme.colors.neutral.light.two,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: theme.spacing.inline.xs),
              ClickableWidget(
                onTap: () {
                  setState(() {
                    _isTermsError = false;
                  });
                  _toggleTerms();
                },
                borderRadius: BorderRadius.circular(theme.borders.radius.medium),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: theme.spacing.inline.xxxs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        isError: _isTermsError,
                        value: _termsAccepted,
                        side: BorderSide(
                          color: _isTermsError ? theme.colors.feedback.error : theme.colors.neutral.dark.two,
                          width: theme.borderWidth.thin,
                        ),
                        activeColor: theme.colors.neutral.dark.two,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            color: _isTermsError ? theme.colors.feedback.error : theme.colors.neutral.light.three,
                          ),
                        ),
                        onChanged: (_) {
                          setState(() {
                            _isTermsError = false;
                          });
                          _toggleTerms();
                        },
                      ),
                      Expanded(
                        child: DSText(
                          RegisterStrings.registerTerms,
                          customStyle: TextStyle(
                            color: theme.colors.neutral.dark.three,
                            fontSize: theme.font.size.xxs,
                            fontWeight: theme.font.weight.medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: theme.spacing.inline.xs),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    context.read<RegisterStepsCubit>().changeStep(RegisterStep.stepTwo);
                  } else if (state is RegisterFailure) {
                    final error = state.error;
                    showDSBottomSheet(
                      context: context,
                      isScrollControlled: false,
                      child: ErrorBottomSheetWidget(
                        message: error ?? RegisterStrings.createAccountErrorLabel,
                      ),
                    );
                  } else if(state is ZipCodeNotProvidedFailure ) {
                    widget.appNavigator.pushReplacementNamed(Routes.zipCodeNotProvided);
                  }
                },
                builder: (context, state) {
                  return DSButton(
                    label: RegisterStrings.continueButton,
                    onPressed: () {
                      if (!_termsAccepted) {
                        setState(() => _isTermsError = true);
                        ScaffoldMessenger.of(context).showDSSnackBar(
                          context,
                          content: DSText(
                            'Please accept the terms and conditions',
                            customStyle: TextStyle(
                              fontSize: theme.font.size.xxs,
                              color: theme.colors.neutral.light.three,
                            ),
                          ),
                        );
                        return;
                      }

                      if (_formKey.currentState!.validate()) {
                        context.read<RegisterCubit>().createAccountStep(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                              phoneNumber: phoneNumberFormatter.getUnmaskedText(),
                              country: RegisterStrings.usaCountryCode,
                            );
                      }
                    },
                    type: DSButtonType.primary,
                    isLoading: state is RegisterLoading,
                    size: DSButtonSize.md,
                  );
                },
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextButton(
                onPressed: () {
                  widget.appNavigator.pushReplacementNamed(Routes.login);
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                  ),
                  maximumSize: WidgetStateProperty.all<Size>(
                    const Size(double.infinity, 40.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DSText(
                      RegisterStrings.accountCreatedLabel,
                      customStyle: TextStyle(
                        color: theme.colors.neutral.dark.three,
                      ),
                    ),
                    DSText(
                      RegisterStrings.logIn,
                      customStyle: TextStyle(
                        color: theme.colors.neutral.dark.three,
                        fontWeight: theme.font.weight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: theme.spacing.inline.sm),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
