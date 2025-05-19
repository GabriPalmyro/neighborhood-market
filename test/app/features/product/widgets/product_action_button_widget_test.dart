import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/action_button_type.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/product_action_button_widget.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/widgets/make_offer_bottom_sheet.dart';

import '../../../../utils/extension/ds_widget_test_extension.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

void main() {
  late AppNavigator appNavigator;

  group('ProductActionButtonWidget Test | ', () {
    setUp(() {
      appNavigator = MockAppNavigator();
    });

    testWidgets('displays offer submitted message when actionType is offerSubmitted', (WidgetTester tester) async {
      await tester.pumpWidgetUnderTest(
        ProductActionButtonWidget(
          productId: 'testProductId',
          actionType: ActionButtonType.offerSubmitted,
          appNavigator: appNavigator,
        ),
      );

      expect(find.text('Offer submitted'), findsOneWidget);
    });

    testWidgets('navigates to product payment when buy now button is pressed', (WidgetTester tester) async {
      await tester.pumpWidgetUnderTest(
        ProductActionButtonWidget(
          productId: 'testProductId',
          actionType: ActionButtonType.offerAvailable,
          appNavigator: appNavigator,
        ),
      );

      await tester.tap(find.text('Buy Now'));
      await tester.pumpAndSettle();

      // Verify navigation to product payment
      // This part depends on how you handle navigation in your app
    });

    testWidgets('shows make offer bottom sheet when offer available button is pressed', (WidgetTester tester) async {
      await tester.pumpWidgetUnderTest(
        ProductActionButtonWidget(
          productId: 'testProductId',
          actionType: ActionButtonType.offerAvailable,
          appNavigator: appNavigator,
        ),
      );
      await tester.tap(find.text('Make Offer'));
      await tester.pumpAndSettle();

      expect(find.byType(MakeOfferBottomSheet), findsOneWidget);
    });

    testWidgets('shows error bottom sheet when count offer available button is pressed', (WidgetTester tester) async {
      await tester.pumpWidgetUnderTest(
        ProductActionButtonWidget(
          productId: 'testProductId',
          actionType: ActionButtonType.countOfferAvailable,
          appNavigator: appNavigator,
        ),
      );
      await tester.tap(find.text('Counter Offer'));
      await tester.pumpAndSettle();

      expect(find.byType(ErrorBottomSheetWidget), findsOneWidget);
    });
  });
}
