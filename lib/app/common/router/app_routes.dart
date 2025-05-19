import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/environment/presentation/page/endpoint_xdebugging_page.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/error/presentation/page/exceptions_page.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/network/channel/environment_channel.dart';
import 'package:neighborhood_market/app/common/xdebugging/presentation/pages/xdebugging_page.dart';
import 'package:neighborhood_market/app/features/create_product/create_product_routes.dart';
import 'package:neighborhood_market/app/features/following/following_routes.dart';
import 'package:neighborhood_market/app/features/login/presentation/login_routes.dart';
import 'package:neighborhood_market/app/features/main/main_routes.dart';
import 'package:neighborhood_market/app/features/manage_cards/manage_cards_routes.dart';
import 'package:neighborhood_market/app/features/my_listing/my_listing_routes.dart';
import 'package:neighborhood_market/app/features/my_profile/my_profile_routes.dart';
import 'package:neighborhood_market/app/features/my_purchases/my_purchases_routes.dart';
import 'package:neighborhood_market/app/features/product_payment/product_payment_routes.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/purchasing_setup_routes.dart';
import 'package:neighborhood_market/app/features/recover_password/recover_password_routes.dart';
import 'package:neighborhood_market/app/features/register/register_routes.dart';
import 'package:neighborhood_market/app/features/seller_profile/seller_profile_routes.dart';
import 'package:neighborhood_market/app/features/splash/splash_routes.dart';

final routes = [
  PageRoute(
    route: Routes.debugging,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => const DebuggingPage(),
    routes: [
      PageRoute(
        route: Routes.debuggingEndpoint,
        transition: PageTransition.rightToLeft,
        builder: (_, __) => EndpointXdebuggingPage(
          environmentChannel: GetIt.I.get<EnvironmentChannel>(),
        ),
      ),
      PageRoute(
        route: Routes.exceptionInterceptor,
        transition: PageTransition.rightToLeft,
        builder: (_, __) => const ExceptionsPage(),
      ),
    ],
  ),
  ...splashRoutes,
  ...registerRoutes,
  ...recoverPasswordRoutes,
  ...loginRoutes,
  ...mainRoutes,
  ...myProfileRoutes,
  ...createProductRoutes,
  ...productPaymentRoutes,
  ...myPurchasesRoutes,
  ...sellerProfileRoutes,
  ...myListingRoutes,
  ...manageCardsRoutes,
  ...purchasingSetupRoutes,
  ...followingRoutes,
];
