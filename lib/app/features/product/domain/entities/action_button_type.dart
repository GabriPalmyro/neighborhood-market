enum ActionButtonType {
  offerAvailable('Make an offer'),
  // buyNow('Buy'),
  offerSubmitted('Make an offer'),
  offerAccepted('Offer accepted'),
  countOfferAvailable('Counter offer available'),
  countOfferAccepted('Counter offer accepted'),
  offerUnavailable('Make an offer'),
  unknown('Unknown');

  const ActionButtonType(this.label);
  final String label;


  static ActionButtonType fromString(String value) {
    switch (value) {
      case 'offerAvailable':
        return offerAvailable;
      case 'buyNow':
        return offerAvailable;
      case 'offerSubmitted':
        return offerSubmitted;
      case 'counterOfferAvailable':
        return countOfferAvailable;
      case 'offerUnavailable':
        return offerUnavailable;
      case 'counterOfferAccepted':
        return countOfferAccepted;
      case 'offerAccepted':
        return offerAccepted;
      default:
        return unknown;
    }
  }
}
