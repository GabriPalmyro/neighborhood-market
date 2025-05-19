import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';

class ZipCodeNotProvidedPage extends StatelessWidget {
  const ZipCodeNotProvidedPage({required this.appNavigator, super.key});

  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    const hangerSize = Size(200, 200);
    return Scaffold(
      backgroundColor: tokens.colors.neutral.light.three,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  tokens.colors.neutral.light.pure.withValues(
                    alpha: .6,
                  ),
                  tokens.colors.neutral.light.pure.withValues(
                    alpha: .3,
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: -40,
            child: ThemeImage(
              ThemeImages.hangerTop,
              size: hangerSize,
            ),
          ),
          const Positioned(
            bottom: 0,
            right: -25,
            child: ThemeImage(
              ThemeImages.hangerBottom,
              size: Size(200, 200),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ThemeImage(
                ThemeImages.logo,
                color: tokens.colors.neutral.dark.pure,
                size: const Size(200, 50),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.inline.md,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DSText(
                    'Oops!',
                    customStyle: TextStyle(
                      fontSize: tokens.font.size.xxl,
                      color: tokens.colors.neutral.dark.pure,
                      fontWeight: tokens.font.weight.bold,
                    ),
                  ),
                  DSText(
                    'Unfortunately, we don’t serve your region yet, but stay tuned for when we do.',
                    textAlign: TextAlign.center,
                    customStyle: TextStyle(
                      fontSize: tokens.font.size.xs,
                      color: tokens.colors.neutral.dark.pure,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.xs),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: DSButton(
                      label: 'Go To homepage',
                      type: DSButtonType.ghost,
                      onPressed: () {
                        appNavigator.pushReplacementNamed(Routes.login);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
