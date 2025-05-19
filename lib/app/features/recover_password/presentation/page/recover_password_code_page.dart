import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/formatter/code_otp_formatter.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/cubit/recover_password_cubit.dart';
import 'package:neighborhood_market/app/features/recover_password/presentation/cubit/recover_password_state.dart';

class RecoverPasswordCodePage extends StatefulWidget {
  const RecoverPasswordCodePage({required this.appNavigator, super.key});
  final AppNavigator appNavigator;

  @override
  State<RecoverPasswordCodePage> createState() => _RecoverPasswordCodePageState();
}

class _RecoverPasswordCodePageState extends State<RecoverPasswordCodePage> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _sendRecoveryCode() {
    if (_codeController.text.length < 6) {
      return;
    }

    context.read<RecoverPasswordCubit>().validateRecoveryCode(
          _codeController.text,
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
            if (state is RecoverPasswordCodeValidated) {
              widget.appNavigator.pushReplacementNamed(
                Routes.recoverPasswordNewPassword,
                queryParameters: {
                  'email': state.email,
                  'jwt': state.jwt,
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
            String? email;
            if (state is RecoverPasswordCodeSent) {
              email = state.email;
            } else if (state is RecoverPasswordError) {
              email = state.email;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DSText(
                  'Check your email',
                  textAlign: TextAlign.center,
                  customStyle: TextStyle(
                    fontSize: tokens.font.size.sm,
                    fontWeight: tokens.font.weight.bold,
                  ),
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                DSText(
                  'We sent a 6-digit confirmation code to $email. Please enter the code below to verify your email address.',
                  textAlign: TextAlign.center,
                  customStyle: TextStyle(
                    fontSize: tokens.font.size.xxs,
                    fontWeight: tokens.font.weight.medium,
                  ),
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                TextInputLabelWidget(
                  label: 'Enter 6-digit code',
                  tooltip: 'Enter the 6-digit code',
                  hintText: 'Enter',
                  formatter: codeOtpFormatter,
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    setState(() {});
                  },
                  onSubmitted: (_) {
                    _sendRecoveryCode();
                  },
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(tokens.borders.radius.medium),
                    color: const Color(0xFFFFF6E7),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.inline.xxs,
                    vertical: tokens.spacing.inline.xxs,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: tokens.spacing.inline.xxxs),
                        child: const DSIcon(
                          icon: DSIcons.info,
                          color: Color(0xFFEC980C),
                          size: DSIconSize.sm,
                        ),
                      ),
                      SizedBox(width: tokens.spacing.inline.xxs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DSText(
                              'Remember',
                              customStyle: TextStyle(
                                color: const Color(0xFF9D6508),
                                fontSize: tokens.font.size.xxxs,
                                fontWeight: tokens.font.weight.bold,
                              ),
                            ),
                            DSText(
                              'If you don’t see the email, check your spam or junk folder. Sometimes emails end up there by mistake.',
                              customStyle: TextStyle(
                                color: const Color(0xFF9D6508),
                                fontSize: tokens.font.size.xxxs,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                DSButton(
                  label: 'Send',
                  isLoading: state is RecoverPasswordLoading,
                  type: _codeController.text.length < 6 ? DSButtonType.ghost : DSButtonType.primary,
                  size: DSButtonSize.md,
                  onPressed: () {
                    _sendRecoveryCode();
                  },
                ),
                SizedBox(height: tokens.spacing.inline.xs),
                ClickableWidget(
                  borderRadius: BorderRadius.circular(tokens.borders.radius.medium),
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: tokens.spacing.inline.xxxs,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSText(
                          'Didn\'t receive the code?',
                          customStyle: TextStyle(
                            color: tokens.colors.neutral.dark.pure,
                            fontSize: tokens.font.size.xxs,
                            fontWeight: tokens.font.weight.medium,
                          ),
                        ),
                        SizedBox(width: tokens.spacing.inline.xxs),
                        DSText(
                          'Resend Code',
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
            );
          },
        ),
      ),
    );
  }
}
