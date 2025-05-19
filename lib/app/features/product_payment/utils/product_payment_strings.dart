class ProductPaymentStrings {
  ProductPaymentStrings._();

  static String stepsTitle(int index) => index != 3 ? 'Payment Step $index of 3' : 'Purchase completed';
  static const String purchaseNotRefundable = 'I understand that this purchase is final and cannot be returned or exchanged';
  static const String notResponsableForItems = 'I understand that Closet Collective is not responsible for the authentication of items or how they are classified on the platform';
}
