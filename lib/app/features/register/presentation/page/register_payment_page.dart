import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/list_item/list_item_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/payment_input_label/payment_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

class RegisterPaymentPage extends StatelessWidget {
  const RegisterPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      appBar: TopbarWidget.stepsTopBar(
        currentStep: 1,
        totalSteps: 1,
        title: const DSText(
          RegisterPaymentString.paymentTitle,
        ),
      ),
      backgroundColor: theme.colors.neutral.light.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.inline.sm,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: theme.spacing.inline.sm),
              DSText(
                RegisterPaymentString.paymentTitle,
                customStyle: TextStyle(
                  fontSize: theme.font.size.sm,
                  fontWeight: theme.font.weight.semiBold,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xxxs),
              DSText(
                RegisterPaymentString.paymentDescription,
                customStyle: TextStyle(
                  fontSize: theme.font.size.xxs,
                  fontWeight: theme.font.weight.regular,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xs),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: theme.colors.neutral.dark.pure.withValues(alpha: 0.25),
                      blurRadius: 20,
                    ),
                  ],
                  color: theme.colors.neutral.light.pure,
                  borderRadius: BorderRadius.circular(theme.borders.radius.medium),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.inline.xs,
                  vertical: theme.spacing.inline.xs,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DSText(
                      'You just have to pay',
                      customStyle: TextStyle(
                        fontSize: theme.font.size.xs,
                        fontWeight: theme.font.weight.semiBold,
                        color: theme.colors.neutral.light.icon,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        DSText(
                          '\$10',
                          customStyle: TextStyle(
                            fontSize: theme.font.size.xl,
                            fontWeight: theme.font.weight.semiBold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: theme.spacing.inline.xxs,
                          ),
                          child: DSText(
                            '.00 per month',
                            customStyle: TextStyle(
                              fontSize: theme.font.size.md,
                              fontWeight: theme.font.weight.semiBold,
                              color: theme.colors.neutral.light.icon,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: theme.spacing.inline.sm),
                    ListItemWidget(
                      leading: CircleAvatar(
                        backgroundColor: theme.colors.feedback.success,
                        child: Icon(
                          Icons.check,
                          color: theme.colors.neutral.light.one,
                          size: 20,
                        ),
                      ),
                      title: RegisterPaymentString.paymentBenefitsOneLabel,
                      subtitle: RegisterPaymentString.paymentBenefitsOneDescription,
                    ),
                    SizedBox(height: theme.spacing.inline.sm),
                    ListItemWidget(
                      leading: CircleAvatar(
                        backgroundColor: theme.colors.feedback.success,
                        child: Icon(
                          Icons.check,
                          color: theme.colors.neutral.light.one,
                          size: 20,
                        ),
                      ),
                      title: RegisterPaymentString.paymentBenefitsTwoLabel,
                      subtitle: RegisterPaymentString.paymentBenefitsTwoDescription,
                    ),
                    SizedBox(height: theme.spacing.inline.sm),
                    ListItemWidget(
                      leading: CircleAvatar(
                        backgroundColor: theme.colors.feedback.success,
                        child: Icon(
                          Icons.check,
                          color: theme.colors.neutral.light.one,
                          size: 20,
                        ),
                      ),
                      title: RegisterPaymentString.paymentBenefitsThreeLabel,
                      subtitle: RegisterPaymentString.paymentBenefitsThreeDescription,
                    ),
                  ],
                ),
              ),
              SizedBox(height: theme.spacing.inline.sm),
              const PaymentInputLabel(
                label: RegisterPaymentString.paymentLabel,
                tooltip: 'Insert your credit card informations',
              ),
              SizedBox(height: theme.spacing.inline.sm),
              DSButton(
                label: 'Paynow',
                onPressed: () {
                  GetIt.I.get<AppNavigator>().pushRoute(Routes.login);
                },
              ),
              SizedBox(height: theme.spacing.inline.sm),
            ],
          ),
        ),
      ),
    );
  }
}
