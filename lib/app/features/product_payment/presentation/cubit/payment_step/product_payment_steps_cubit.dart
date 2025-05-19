import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/product_payment_steps_enum.dart';
import 'package:neighborhood_market/app/features/product_payment/presentation/cubit/payment_step/product_payment_steps_state.dart';

@injectable
class ProductPaymentStepsCubit extends Cubit<ProductPaymentCurrentStep> {
  ProductPaymentStepsCubit()
      : super(
          const ProductPaymentCurrentStep(
            currentStep: ProductPaymentStep.stepOne,
          ),
        );

  PageController pageController = PageController();

  void _animateToPage(int index) {
    if (pageController.hasClients) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
  }

  Future<void> changeStep(ProductPaymentStep step) async {
    emit(ProductPaymentCurrentStep(currentStep: step));
    _animateToPage(step.stepIndex);
  }

  void backStep() {
    final backStep = state.currentStep.backStep();
    changeStep(backStep);
  }

  void nextStep() {
    final nextStep = state.currentStep.nextStep();
    changeStep(nextStep);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
