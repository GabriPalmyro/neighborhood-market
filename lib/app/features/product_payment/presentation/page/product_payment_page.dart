import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/product_payment_steps_enum.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/payment_step/product_payment_steps_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/payment_step/product_payment_steps_state.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/steps/product_payment_infos_step.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/steps/product_payment_order_step.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/steps/purchase_completed_step.dart';
import 'package:neighborhood_market/app/features/product_payment/utils/product_payment_strings.dart';

class ProductPaymentPage extends StatelessWidget {
  const ProductPaymentPage({
    required this.appNavigator,
    super.key,
  });

  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<ProductPaymentStepsCubit, ProductPaymentCurrentStep>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.colors.neutral.light.pure,
          appBar: TopbarWidget.stepsTopBar(
            title: DSText(
              ProductPaymentStrings.stepsTitle(state.currentStep.stepIndex + 1),
              customStyle: TextStyle(
                fontSize: theme.font.size.xs,
                fontWeight: theme.font.weight.semiBold,
              ),
            ),
            totalSteps: ProductPaymentStep.values.length,
            currentStep: state.currentStep.stepIndex + 1,
            onBack: () {
              if (state.currentStep == ProductPaymentStep.stepTwo) {
                context.read<ProductPaymentStepsCubit>().backStep();
                return;
              }
              appNavigator.pop();
            },
          ),
          body: PageView(
            controller: context.watch<ProductPaymentStepsCubit>().pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              ProductPaymentOrderStep(),
              ProductPaymentInfosStep(),
              PurchaseCompletedStep(),
            ],
          ),
        );
      },
    );
  }
}
