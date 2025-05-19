import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/router_config.dart';
import 'package:neighborhood_market/app/di/external_modules.dart';
import 'package:neighborhood_market/app/di/injection.config.dart';

@InjectableInit(
  initializerName: r'$initAppGetIt',
  externalPackageModulesBefore: externalModules,
)
Future<void> configureAppDependencies(
  GetIt getIt,
  List<PageRoute> routes,
) async {
  getIt.$initAppGetIt();

  getIt.registerLazySingleton<AppRouterConfig>(
    () => AppRouterConfig(
      routes: routes,
    ),
  );
}
