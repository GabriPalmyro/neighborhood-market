import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

extension WidgetTestExtension on WidgetTester {
  Future<void> pumpWidgetUnderTest(Widget child) async {
    await pumpWidget(
      DSTheme(
        data: DSThemeAppData(),
        child: MaterialApp(
          home: child,
        ),
      ),
    );
  }
}
