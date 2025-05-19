abstract class PaymentExceptions implements Exception {
  const PaymentExceptions();
}

class PaymentDialogDismissed extends PaymentExceptions {
  const PaymentDialogDismissed();

  @override
  String toString() => 'There payment dialog was dismissed. Please try again later.';
}

class PaymentDialogException extends PaymentExceptions {
  const PaymentDialogException();

  @override
  String toString() => 'There was an error with the payment dialog. Please try again later.';
}

class PaymentGeneralException extends PaymentExceptions {
  const PaymentGeneralException(this.message);
  final String message;

  @override
  String toString() => message;
}

class PaymentIntentException extends PaymentExceptions {
  const PaymentIntentException();

  @override
  String toString() => 'There was an error with the payment intent. Please try again later.';
}

class PaymentMethodException extends PaymentExceptions {
  const PaymentMethodException();

  @override
  String toString() => 'There was an error with the payment method. Please try again later.';
}

class PaymentConfirmationException extends PaymentExceptions {
  const PaymentConfirmationException();

  @override
  String toString() => 'There was an error with the payment. Please try again later.';
}