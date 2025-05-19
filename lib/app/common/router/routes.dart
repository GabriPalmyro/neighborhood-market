enum Routes {
  // Debugging
  debugging('/debugging'),
  debuggingEndpoint('/debugging_endpoint'),
  exceptionInterceptor('/exception_interceptor'),

  // Not Logged
  splash('/splash'),
  register('/register'),
  registerPayment('/register_payment'),
  login('/login'),
  zipCodeNotProvided('/zipCodeNotProvided'),

  // Recover Password
  recoverPassword('/recover_password'),
  recoverPasswordCode('/recover_password_code'),
  recoverPasswordNewPassword('/recover_password_new_password'),
  recoverPasswordSuccess('/recover_password_success'),

  // Logged
  main('/main'),
  filter('/filter'),
  filterCategory('/filter/category'),

  // My Profile
  myProfile('/my_profile'),
  updatePassword('/update_password'),
  following('/following'),

  // Product
  product('/product'),
  productPayment('/product_payment'),

  // Notifications
  notifications('/notifications'),

  // Create Product
  selectProductCategory('/select_product_category'),
  createProduct('/create_product'),

  // My Purchases
  myPurchases('/my_purchases'),
  myPurchaseDetails('/purchase_details'),
  
  // My Listing
  myListing('/my_listing'),

  // Manager Cards
  manageCards('/manage_cards'),

  // Purchasing Setup
  purchasingSetup('/purchasing_setup'),

  // Public Profile
  sellerProfile('/seller_profile'),
  sellerReviews('/seller_reviews');

  const Routes(this.path);

  final String path;
  
  Routes getRoute(String path) {
    return Routes.values.firstWhere(
      (route) => route.path == path,
      orElse: () => Routes.debugging,
    );
  }

  @override
  String toString() => path;
}
