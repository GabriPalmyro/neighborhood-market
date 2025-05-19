import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/manage_cards/presentation/cubit/manage_cards_cubit.dart';
import 'package:neighborhood_market/app/features/manage_cards/presentation/widgets/add_new_payment_method_widget.dart';
import 'package:neighborhood_market/app/features/manage_cards/presentation/widgets/billing_informations_widget.dart';
import 'package:neighborhood_market/app/features/manage_cards/presentation/widgets/credit_card_widget.dart';
import 'package:neighborhood_market/app/features/manage_cards/utils/manage_cards_strings.dart';

class ManageCardsPage extends StatelessWidget {
  const ManageCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      appBar: TopbarWidget.defaultTopBar(
        centerTitle: false,
        title: DSText(
          ManageCardStrings.manageCards,
          customStyle: TextStyle(
            fontSize: theme.font.size.xs,
            fontWeight: theme.font.weight.bold,
          ),
        ),
      ),
      backgroundColor: theme.colors.neutral.light.background,
      body: BlocBuilder<ManageCardsCubit, ManageCardsState>(
        builder: (_, state) {
          return FadeSwitcherState<ManageCardsState, ManageCardsLoaded, ManageCardsError, ManageCardsLoading>(
            error: (_) => MainPageErrorWidget(
              onRetry: () {
                context.read<ManageCardsCubit>().getManageCards(
                      userId: '1',
                    );
              },
            ),
            loading: (_) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.inline.xs,
                ),
                child: Column(
                  children: [
                    SizedBox(height: theme.spacing.inline.sm),
                    const ShimmerComponent(
                      width: double.infinity,
                      height: 80,
                    ),
                    SizedBox(height: theme.spacing.inline.xs),
                    const ShimmerComponent(
                      width: double.infinity,
                      height: 45,
                    ),
                    SizedBox(height: theme.spacing.inline.xs),
                    const ShimmerComponent(
                      width: double.infinity,
                      height: 45,
                    ),
                    SizedBox(height: theme.spacing.inline.xs),
                    const ShimmerComponent(
                      width: double.infinity,
                      height: 45,
                    ),
                  ],
                ),
              );
            },
            result: (success) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing.inline.xs,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: theme.spacing.inline.xs),
                      BillingInformationsWidget(
                        renewDate: success.entity.billingInformation.renewDate,
                        price: success.entity.billingInformation.renewPrice,
                      ),
                      SizedBox(height: theme.spacing.inline.sm),
                      DSText(
                        'Payment with',
                        customStyle: TextStyle(
                          fontSize: theme.font.size.xs,
                          fontWeight: theme.font.weight.medium,
                        ),
                      ),
                      SizedBox(height: theme.spacing.inline.xxs),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: success.entity.creditCards.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: theme.spacing.inline.xs,
                            ),
                            child: CreditCardWidget(
                              finalDigits: success.entity.creditCards[index].finalDigits,
                            ),
                          );
                        },
                      ),
                      const AddNewPaymentMethodWidget(),
                    ],
                  ),
                ),
              );
            },
            state: state,
          );
        },
      ),
    );
  }
}
