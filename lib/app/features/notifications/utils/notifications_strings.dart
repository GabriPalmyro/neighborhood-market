class NotificationsStrings {
  NotificationsStrings._();

  static const String title = 'Notifications';

  static String deeplinkProduct(String itemId) => 'neighborhood://main/product_payment?productId=$itemId';

  static String deeplinkOffer(String itemId, String offerId, String offerPrice) =>
      'neighborhood://main/product_payment?productId=$itemId&offerId=$offerId&purchaseType=offer&productOfferPrice=$offerPrice';

  static String deeplinkCounterOffer(String itemId, String offerId, String offerPrice) =>
      'neighborhood://main/product_payment?productId=$itemId&offerId=$offerId&purchaseType=counterOffer&productOfferPrice=$offerPrice';
}
