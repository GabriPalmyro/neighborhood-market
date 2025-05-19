import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/local_database/local_database.dart';
import 'package:neighborhood_market/app/features/register/domain/entity/register_steps_enum.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register_step/register_steps_state.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

@injectable
class RegisterStepsCubit extends Cubit<RegisterCurrentStep> {
  RegisterStepsCubit(
    this.localStorage,
  ) : super(
          const RegisterCurrentStep(currentStep: RegisterStep.stepOne),
        );

  final LocalStorage localStorage;

  late final PageController pageController;

  Future<void> init({int? page}) async {
    if (page != null) {
      emit(RegisterCurrentStep(currentStep: RegisterStep.values[page]));
      pageController = PageController(initialPage: page);
      return;
    }

    pageController = PageController();

    // final stepIndex = await localStorage.getData<int?>(RegisterStrings.stepLocalKey);
    // if (stepIndex != null) {
    //   final step = RegisterStep.values[stepIndex];
    //   emit(RegisterCurrentStep(currentStep: step));
    //   _goToPage(step.stepIndex);
    // }
  }

  // void _goToPage(int index) {
  //   if (pageController.hasClients) {
  //     pageController.jumpToPage(index);
  //   }
  // }

  void _animateToPage(int index) {
    if (pageController.hasClients) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
  }

  Future<void> changeStep(RegisterStep step) async {
    emit(RegisterCurrentStep(currentStep: step));
    _animateToPage(step.stepIndex);

    if (step == RegisterStep.stepFour) {
      await localStorage.removeData(RegisterStrings.stepLocalKey);
    } else {
      await localStorage.saveData<int>(RegisterStrings.stepLocalKey, step.stepIndex);
    }
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
