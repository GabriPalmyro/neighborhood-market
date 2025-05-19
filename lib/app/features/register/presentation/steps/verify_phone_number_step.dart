import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/formatter/code_otp_formatter.dart';
import 'package:neighborhood_market/app/core/core.dart';
import 'package:neighborhood_market/app/features/register/domain/entity/register_steps_enum.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register/register_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register/register_state.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_cubit.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

class VerifyPhoneNumberStep extends StatefulWidget {
  const VerifyPhoneNumberStep({super.key});

  @override
  State<VerifyPhoneNumberStep> createState() => _VerifyPhoneNumberStepState();
}

class _VerifyPhoneNumberStepState extends State<VerifyPhoneNumberStep> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                RegisterStrings.verifyNumber,
                customStyle: TextStyle(
                  fontSize: theme.font.size.sm,
                  fontWeight: theme.font.weight.semiBold,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xxxs),
              DSText(
                RegisterStrings.verifyNumberDescription,
                customStyle: TextStyle(
                  fontSize: theme.font.size.xxs,
                  fontWeight: theme.font.weight.regular,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xs),
              TextInputLabelWidget(
                controller: _codeController,
                formatter: codeOtpFormatter,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Please enter the code';
                  } else if (value!.length < AppConsts.otpCodeLenght) {
                    return 'The code must have 6 digits';
                  }
                  return null;
                },
                label: 'Code',
                tooltip: 'Code',
                hintText: 'Enter the code',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: theme.spacing.inline.xs),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    context.read<RegisterStepsCubit>().changeStep(RegisterStep.stepThree);
                  } else if (state is RegisterFailure) {
                    showDSBottomSheet(
                      context: context,
                      isScrollControlled: false,
                      child: const ErrorBottomSheetWidget(
                        message: 'There was an error, please try again',
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return DSButton(
                    label: RegisterStrings.continueButton,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RegisterCubit>().verifyPhoneNumberStep(code: _codeController.text);
                      }
                    },
                    isLoading: state is RegisterLoading,
                    size: DSButtonSize.md,
                  );
                },
              ),
              SizedBox(height: theme.spacing.inline.xxxs),
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO(gabriel): Resend sms code
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                    ),
                    maximumSize: WidgetStateProperty.all<Size>(
                      const Size(double.infinity, 40.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: theme.spacing.inline.xs),
                    child: DSText(
                      'Resend code',
                      customStyle: TextStyle(
                        color: theme.colors.neutral.dark.three,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: theme.spacing.inline.sm),
            ],
          ),
        ),
      ),
    );
  }
}
