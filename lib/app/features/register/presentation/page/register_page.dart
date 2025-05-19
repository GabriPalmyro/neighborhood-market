import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/register/domain/entity/register_steps_enum.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_cubit.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_state.dart';
import 'package:neighborhood_market/app/features/register/presentation/steps/account_review_step.dart';
import 'package:neighborhood_market/app/features/register/presentation/steps/create_account_step.dart';
import 'package:neighborhood_market/app/features/register/presentation/steps/personal_information_step.dart';
import 'package:neighborhood_market/app/features/register/presentation/steps/verify_phone_number_step.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    required this.appNavigator,
    super.key,
  });

  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<RegisterStepsCubit, RegisterCurrentStep>(
      builder: (context, state) {
        final step = state.currentStep;
        return Scaffold(
          backgroundColor: theme.colors.neutral.light.background,
          appBar: TopbarWidget.stepsTopBar(
            title: DSText(
              RegisterStrings.stepsTitle(step.stepIndex + 1),
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.medium,
              ),
            ),
            totalSteps: RegisterStep.values.length,
            currentStep: step.stepIndex + 1,
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: context.watch<RegisterStepsCubit>().pageController,
            children: [
              CreateAccountStep(
                appNavigator: appNavigator,
              ),
              const VerifyPhoneNumberStep(),
              const PersonalInformationStep(),
              AccountReviewStep(
                appNavigator: appNavigator,
              ),
            ],
          ),
        );
      },
    );
  }
}
