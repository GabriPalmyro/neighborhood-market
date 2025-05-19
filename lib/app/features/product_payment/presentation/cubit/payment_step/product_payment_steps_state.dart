import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/product_payment_steps_enum.dart';

abstract class ProductPaymentStepsState extends Equatable {
  const ProductPaymentStepsState();

  @override
  List<Object> get props => [];
}

class ProductPaymentCurrentStep extends ProductPaymentStepsState {
  const ProductPaymentCurrentStep({
    required this.currentStep,
  });

  ProductPaymentCurrentStep copyWith({
    ProductPaymentStep? currentStep,
  }) {
    return ProductPaymentCurrentStep(
      currentStep: currentStep ?? this.currentStep,
    );
  }

  final ProductPaymentStep currentStep;

  @override
  List<Object> get props => [currentStep];
}
