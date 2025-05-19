enum ProductPaymentStep {
  stepOne(0),
  stepTwo(1),
  stepThree(2);

  const ProductPaymentStep(this.stepIndex);
  final int stepIndex;

  ProductPaymentStep nextStep() {
    switch (this) {
      case stepOne:
        return stepTwo;
      case stepTwo:
        return stepThree;
      case stepThree:
        return stepThree;
    }
  }

  ProductPaymentStep backStep() {
    switch (this) {
      case stepOne:
        return stepOne;
      case stepTwo:
        return stepOne;
      case stepThree:
        return stepTwo;
    }
  }
}
