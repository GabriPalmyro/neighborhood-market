enum PurchaseType {
  unknown,
  buy,
  offer,
  counterOffer;

  static PurchaseType fromString(String value) {
    switch (value) {
      case 'buy':
        return PurchaseType.buy;
      case 'offer':
        return PurchaseType.offer;
      case 'counterOffer':
        return PurchaseType.counterOffer;
      default:
        return PurchaseType.unknown;
    }
  }

  String toValue() {
    switch (this) {
      case PurchaseType.buy:
        return 'buyNow';
      case PurchaseType.offer:
        return 'offer';
      case PurchaseType.counterOffer:
        return 'counterOffer';
      default:
        return 'unknown';
    }
  }

  String purchaseEndpoint() {
    switch (this) {
      case PurchaseType.buy:
        return '/item/buy';
      case PurchaseType.offer:
        return '/item/offer/buy';
      case PurchaseType.counterOffer:
        return '/item/offer/counter/buy';
      default:
        return 'Unknown';
    }
  }
}
