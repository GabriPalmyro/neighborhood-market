import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/my_listing/presentation/pages/my_listing_page.dart';

final myListingRoutes = [
  PageRoute(
    route: Routes.myListing,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => const MyListingPage(),
  ),
];
