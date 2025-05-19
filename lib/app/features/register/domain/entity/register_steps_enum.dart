enum RegisterStep {
  stepOne(0),
  stepTwo(1),
  stepThree(2),
  stepFour(3);
  
  const RegisterStep(this.stepIndex);
  final int stepIndex;

  RegisterStep nextStep() {
    switch (this) {
      case stepOne:
        return stepTwo;
      case stepTwo:
        return stepThree;
      case stepThree:
        return stepFour;
      case stepFour:
        return stepFour;
    }
  }

  RegisterStep backStep() {
    switch (this) {
      case stepOne:
        return stepOne;
      case stepTwo:
        return stepOne;
      case stepThree:
        return stepTwo;
      case stepFour:
        return stepThree;
    }
  }
}
