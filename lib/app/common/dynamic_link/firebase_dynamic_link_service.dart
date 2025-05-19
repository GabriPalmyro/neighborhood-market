// ignore_for_file: deprecated_member_use

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/dynamic_link/dynamic_link_service.dart';
import 'package:neighborhood_market/app/common/feature_flags/feature_flag_service.dart';
import 'package:neighborhood_market/app/core/core.dart';

@Injectable(as: DynamicLinkService)
class FirebaseDynamicLinkService implements DynamicLinkService {
  FirebaseDynamicLinkService(this._featureFlagService);

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  final FeatureFlagService _featureFlagService;

  // void observeDeeplinkCalls() {
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     log('Dynamic link received: ${dynamicLinkData.link}');
  //     handleDeepLink(dynamicLinkData.link);
  //   }).onError((error) {
  //     log('Error: $error');
  //   });

  //   dynamicLinks.getInitialLink().then((initialLinkData) {
  //     if (initialLinkData != null) {
  //       log('Initial dynamic link: ${initialLinkData.link}');
  //       handleDeepLink(initialLinkData.link);
  //     }
  //   });
  // }

  // void handleDeepLink(Uri link) {
  //   if (link.path == '/product' && link.queryParameters.containsKey('id')) {
  //     final productId = link.queryParameters['id'];
  //     log('Navigate to product: $productId');
  //     // Navegação para a página do produto
  //   }
  // }

  @override
  Future<String> createProductDynamicLink(String productId) async {
    final urlPrefix = await _featureFlagService.getString(AppStrings.deeplinkSharePrefixKey);
    final fallbackUrl = await _featureFlagService.getString(AppStrings.defaultFallbackUrlKey);

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: AppStrings.firebaseUrlPrefix,
      link: Uri.parse('$urlPrefix/product?id=$productId'),
      navigationInfoParameters: const NavigationInfoParameters(
        forcedRedirectEnabled: true,
      ),
      androidParameters: AndroidParameters(
        packageName: AppStrings.androidBundleId,
        fallbackUrl: Uri.parse(fallbackUrl),
      ),
      iosParameters: IOSParameters(
        bundleId: AppStrings.iosBundleId,
        appStoreId: AppStrings.appStoreId,
        fallbackUrl: Uri.parse(fallbackUrl),
      ),
    );

    final shortLink = await FirebaseDynamicLinks.instance.buildShortLink(
      parameters,
    );

    return shortLink.shortUrl.toString();
  }
}
