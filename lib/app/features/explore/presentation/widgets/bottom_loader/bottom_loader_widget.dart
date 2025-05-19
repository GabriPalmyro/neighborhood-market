import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return  Center(
      child: SizedBox(
        width: double.infinity,
        height: 30,
        child: SpinKitCircle(
          color: theme.colors.brand.secondary,
          size: 30,
        ),
      ),
    );
  }
}
