import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_routes.dart';
import 'package:neighborhood_market/app/common/router/router_config.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/xdebugging/external/error_banner_factory.dart';
import 'package:neighborhood_market/app/di/injection.dart';
import 'package:neighborhood_market/firebase_options.dart';

import 'app/common/xdebugging/features/error/domain/interceptors/exceptions_interceptor.dart';
import 'app/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: AppStrings.dotEnvPath);

  final GetIt getIt = GetIt.instance;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureAppDependencies(getIt, routes);

  final DSThemeData theme = DSThemeAppData();

  const isRelease = bool.fromEnvironment('IS_RELEASE', defaultValue: false);

  final exceptionInterceptor = ExceptionInterceptor()..initialize();
  exceptionInterceptor.captureAsyncErrors(() {
    runApp(MyApp(theme: theme, isRelease: isRelease));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({
    required this.theme,
    required this.isRelease,
    super.key,
  });

  final DSThemeData theme;
  final bool isRelease;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouterConfig routerConfig = GetIt.I();

  @override
  Widget build(BuildContext context) {
    final debugBanner = ErrorBannerFactory.buildBanner(() {
      routerConfig.router.pushNamed(Routes.debugging.name);
    });
    return DSTheme(
      data: widget.theme,
      child: MaterialApp.router(
        builder: widget.isRelease ? null : debugBanner.createBuilderBanner,
        theme: ThemeData(
          primaryColor: widget.theme.designTokens.colors.brand.primary,
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.grey,
            cursorColor: widget.theme.designTokens.colors.brand.primary,
            selectionHandleColor: widget.theme.designTokens.colors.brand.primary,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all<Color>(
                widget.theme.designTokens.colors.brand.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          tabBarTheme: TabBarTheme(
            unselectedLabelColor: widget.theme.designTokens.colors.neutral.light.two,
            labelColor: widget.theme.designTokens.colors.brand.secondary,
            indicatorColor: widget.theme.designTokens.colors.brand.secondary,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          fontFamily: widget.theme.designTokens.font.family.base,
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        debugShowCheckedModeBanner: false,
        routerConfig: routerConfig.router,
        title: AppStrings.title,
      ),
    );
  }
}
