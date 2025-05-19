class RegisterStrings {
  RegisterStrings._();

  static String stepsTitle(int index) => 'Step $index of 4';
  static const String stepLocalKey = 'current_step_key';

  // Step One
  static const String stepOneEndpoint = '/account';
  static const String createAccount = 'Create Account';
  static const String createAccountDescription = 'To get started, create an account. This helps us keep your information safe and secure.';
  static const String registerTerms = 'I confirm that I have thoroughly read and agree to the terms outlined in our User Agreement and Privacy Policy.';
  static const String continueButton = 'Continue';
  static const String backButton = 'Back';
  static const String accountCreatedLabel = 'Do you already have an account?';
  static const String logIn = ' Log In';
  static const String usaCountryCode = '+1';
  static const String createAccountErrorLabel = 'There was an error creating your account. Please try again.';

  // Step Two
  static const String stepTwoEndpoint = '/account/validate/';
  static const String verifyNumber = 'Verify Phone Number';
  static const String verifyNumberDescription = 'We just sent a 6-digit code to your phone number, enter it below.';

  // Step Three
  static const String stepThreeEndpoint = '/account/last-step';
  static const String personalInfomation = 'Personal Information';
  static const String personalInfomationDescription =
      'To get started, create an account. Your personal information is only used to verify you reside in the service area, ensuring your data is kept safe and secure.';
}

class RegisterPaymentString {
  RegisterPaymentString._();

  static const String paymentTitle = 'Final Step, Make the Payment';
  static const String paymentDescription =
      'To finalize your registration and gain access to the platform, kindly complete your payment using a valid credit card.';

  static const String paymentLabel = 'Payment';
  static const String paymentBenefitsOneLabel = 'Access to Local Listings';
  static const String paymentBenefitsOneDescription = 'Discover unique listings from sellers in your neighborhood, exclusively available to paid members. Stay updated with local offers for a personalized shopping experience within your community.';
  static const String paymentBenefitsTwoLabel = 'Exclusive Neighborhood Offers';
  static const String paymentBenefitsTwoDescription = 'Enjoy special discounts and promotions from local businesses, only for members. Get access to deals that help you save while supporting businesses nearby.';
  static const String paymentBenefitsThreeLabel = 'Full Platform Access';
  static const String paymentBenefitsThreeDescription = 'Unlock the platform’s full features, allowing you to browse, buy, and interact with local sellers securely. Paid membership ensures seamless transactions and communication.';
}
