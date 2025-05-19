class WhiteGloveStrings {
  WhiteGloveStrings._();

  static String whiteGloveListingService(int index) {
    if (index > 0) {
      return '${index + 1}# White Glove Listing Services';
    }

    return 'White Glove Listing Service';
  }

  static const String whiteGloveListingServiceDescription =
      'Do you want to list an item, but don\'t have time to do it yourself? Click the button below to request our white glove listing service. We will pick up the item at your address and list it for sale under your account.';
  static const String standartCommissionValueLabel = 'Commission value: 20%';
  static const String whiteGloveCommissionValueLabel = 'Commission value: 25%';
  static String finalTakeHomeValueLabel(String value) => 'Final take home amount: $value';
}
