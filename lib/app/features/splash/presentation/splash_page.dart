import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/login/presentation/widgets/reactivate_account_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/splash/presentation/cubit/splash_cubit_cubit.dart';
import 'package:neighborhood_market/app/features/splash/utils/splash_strings.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({required this.appNavigator, super.key});
  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          appNavigator.pushReplacementNamed(Routes.main);
        } else if (state is SplashDeactivated) {
          showDSBottomSheet(
            context: context,
            isScrollControlled: false,
            child: const ReactivateAccountBottomSheet(),
          );
        }
      },
      builder: (context, state) {
        final isUnauthenticated = state is SplashUnauthenticated || state is SplashDeactivated;
        return Stack(
          fit: StackFit.expand,
          children: [
            const ThemeImage(
              ThemeImages.backgroundSplash,
              fit: BoxFit.cover,
            ),
            Container(
              color: tokens.colors.neutral.dark.pure.withValues(alpha: .3),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            // Center(
            //   child: ThemeImage(
            //     ThemeImages.logoForeground,
            //     color: tokens.colors.neutral.light.pure,
            //     size: Size(
            //       MediaQuery.of(context).size.width * 0.8,
            //       250,
            //     ),
            //   ),
            // ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeInOutCirc,
              bottom: isUnauthenticated ? 0 : -150,
              left: 20,
              right: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isUnauthenticated ? 1 : 0,
                    child: DSButton(
                      label: SplashStrings.startButton,
                      type: DSButtonType.secondary,
                      size: DSButtonSize.md,
                      onPressed: () {
                        appNavigator.pushRoute(Routes.register);
                      },
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.xxxs),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isUnauthenticated ? 1 : 0,
                    child: TextButton(
                      onPressed: () {
                        appNavigator.pushRoute(Routes.login);
                      },
                      child: DSText(
                        SplashStrings.loginButton,
                        customStyle: TextStyle(
                          color: tokens.colors.neutral.light.pure,
                          fontSize: tokens.font.size.xs,
                          fontWeight: tokens.font.weight.semiBold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: tokens.spacing.inline.lg),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
