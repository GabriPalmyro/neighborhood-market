import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/register/domain/entity/register_steps_enum.dart';

abstract class RegisterStepsState extends Equatable {
  const RegisterStepsState();

  @override
  List<Object> get props => [];
}

class RegisterCurrentStep extends RegisterStepsState {
  const RegisterCurrentStep({
    required this.currentStep,
  });

  RegisterCurrentStep copyWith({
    RegisterStep? currentStep,
  }) {
    return RegisterCurrentStep(
      currentStep: currentStep ?? this.currentStep,
    );
  }

  final RegisterStep currentStep;

  @override
  List<Object> get props => [currentStep];
}
