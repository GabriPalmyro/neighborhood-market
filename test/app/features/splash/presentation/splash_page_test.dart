import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/splash/presentation/splash_page.dart';
import 'package:neighborhood_market/app/features/splash/utils/splash_strings.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

void main() {
  late MockAppNavigator mockAppNavigator;

  setUp(() {
    mockAppNavigator = MockAppNavigator();
    when(() => mockAppNavigator.pushRoute(Routes.register)).thenAnswer((_) async {});
    when(() => mockAppNavigator.pushRoute(Routes.login)).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return DSTheme(
      data: DSThemeAppData(),
      child: MaterialApp(
        home: SplashPage(appNavigator: mockAppNavigator),
      ),
    );
  }

  group('SplashPage Tests', () {
    testWidgets('SplashPage displays background image and logo', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ThemeImage), findsNWidgets(2));
    });

    testWidgets('SplashPage displays start button and login button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(SplashStrings.startButton), findsOneWidget);
      expect(find.text(SplashStrings.loginButton), findsOneWidget);
    });

    testWidgets('Start button navigates to register route', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text(SplashStrings.startButton));
      await tester.pumpAndSettle();

      verify(() => mockAppNavigator.pushRoute(Routes.register)).called(1);
    });

    testWidgets('Login button navigates to login route', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text(SplashStrings.loginButton));
      await tester.pumpAndSettle();

      verify(() => mockAppNavigator.pushRoute(Routes.login)).called(1);
    });
  });
}
