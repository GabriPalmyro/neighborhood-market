class MyPurchasesStrings {
  MyPurchasesStrings._();

  static const String myPurchases = 'My Purchases';
  static const String inProgress = 'In Progress';
  static const String completed = 'Completed';
  static const String deliverySuccessfully = 'Delivery Completed Successfully!';

  static String deliverySubtitle(String productName) {
    return 'Your order has been delivered. We hope you enjoy your $productName!';
  }

  static const String review = 'Review';
  static const String sellerReviews = 'Seller Reviews';
}
