import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/card/card_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/presentation/cubit/purchasing_setup_cubit.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/presentation/widgets/payment_methods/payment_method_widget.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/utils/purchasing_setup_strings.dart';

class PurchasingSetupPage extends StatelessWidget {
  const PurchasingSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      appBar: TopbarWidget.defaultTopBar(
        centerTitle: false,
        title: DSText(
          PurchasingSetupStrings.purchasingSetup,
          customStyle: TextStyle(
            fontSize: theme.font.size.xs,
            fontWeight: theme.font.weight.bold,
          ),
        ),
      ),
      backgroundColor: theme.colors.neutral.light.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.inline.xs,
            vertical: theme.spacing.inline.xs,
          ),
          child: Column(
            children: [
              ThemeCardWidget(
                borderRadius: BorderRadius.circular(theme.borders.radius.medium),
                child: Padding(
                  padding: EdgeInsets.all(theme.spacing.inline.xs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DSText(
                        PurchasingSetupStrings.manageMethods,
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xxs,
                          fontWeight: theme.font.weight.medium,
                        ),
                      ),
                      SizedBox(height: theme.spacing.inline.xxxs),
                      DSText(
                        PurchasingSetupStrings.manageMethodsDescription,
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xxs,
                          color: theme.colors.neutral.dark.icon,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: theme.spacing.inline.xs),
              BlocBuilder<PurchasingSetupCubit, PurchasingSetupState>(
                builder: (context, state) {
                  return FadeSwitcherState<PurchasingSetupState, PurchasingSetupLoaded, PurchasingSetupError, PurchasingSetupLoading>(
                    error: (_) => MainPageErrorWidget(onRetry: () {}),
                    loading: (_) => Center(
                      child: Column(
                        children: List.generate(
                          5,
                          (index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: theme.spacing.inline.xs,
                            ),
                            child: const ShimmerComponent(
                              width: double.infinity,
                              height: 70,
                            ),
                          ),
                        ),
                      ),
                    ),
                    result: (result) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: result.paymentMethods.length,
                        itemBuilder: (context, index) {
                          final entity = result.paymentMethods[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: theme.spacing.inline.xs,
                            ),
                            child: PaymentMethodWidget(entity: entity),
                          );
                        },
                      );
                    },
                    state: state,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
