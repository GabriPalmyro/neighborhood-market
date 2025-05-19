class ProductStrings {
  ProductStrings._();

  static const String buyLabel = 'Buy';
  static const String offerSubmittedMessage = 'You\'ve already submitted an offer. Please wait for the seller\'s response. After 48 hours, you can submit a new offer if needed.';
  static const String counterOfferNotAvailable = 'Counter-offer response not available inside the product page.';
  static const String offerSentSuccessfully = 'Offer sent successfully';
}

class OfferResponseStrings {
  OfferResponseStrings._();
  static const String offerResponseTitle = 'Accept offer or make a counter-offer';
  static const String offerResponseInfo = 'The buyer will have 48 hours to respond to your counteroffer or complete the purchase.';
  static const String declineOffer = 'Decline';
  static const String acceptOffer = 'Accept';
  static const String submitCounterOffer = 'Send Counter-offer';
}

class CounterOfferResponseStrings {
  CounterOfferResponseStrings._();
  static const String counterOfferResponseTitle = 'Review and respond to the seller\'s counter-offer';
  static const String counterOfferResponseInfo = 'You have 48 hours to respond to this counteroffer or finalize the purchase';
  static const String declineCounterOffer = 'Decline';
  static const String acceptCounterOffer = 'Accept';
}