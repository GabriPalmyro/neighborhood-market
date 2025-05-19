import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/common/formatter/price_formatter.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/cubit/offer_cubit.dart';
import 'package:neighborhood_market/app/features/product/utils/product_strings.dart';

class CountOfferResponseBottomSheet extends StatelessWidget {
  const CountOfferResponseBottomSheet({
    required this.appNavigator,
    required this.offerId,
    required this.counterOfferPrice,
    required this.itemId,
    required this.itemName,
    super.key,
  });

  final AppNavigator appNavigator;
  final String offerId;
  final double counterOfferPrice;
  final String itemId;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (_) => GetIt.I.get<OfferCubit>(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          theme.spacing.inline.xs,
          theme.spacing.inline.xs,
          theme.spacing.inline.xs,
          MediaQuery.of(context).viewInsets.bottom + theme.spacing.inline.xs,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSText(
              CounterOfferResponseStrings.counterOfferResponseTitle,
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            RichText(
              text: TextSpan(
                text: 'You\'ve received a counteroffer for ',
                style: TextStyle(
                  fontSize: theme.font.size.xxs,
                  fontWeight: theme.font.weight.regular,
                  color: theme.colors.neutral.dark.two,
                  fontFamily: theme.font.family.base,
                ),
                children: [
                  TextSpan(
                    text: itemName,
                    style: TextStyle(
                      fontSize: theme.font.size.xxs,
                      fontWeight: theme.font.weight.bold,
                      color: theme.colors.brand.secondary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        GetIt.I<AppNavigator>().pushRoute(
                          Routes.product,
                          queryParameters: {
                            'id': itemId,
                          },
                        );
                      },
                  ),
                  TextSpan(
                    text: '. You can now choose to accept the new price or decline the offer.',
                    style: TextStyle(
                      fontFamily: theme.font.family.base,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            TextInputLabelWidget(
              label: 'Seller\'s Counter-offer Price',
              hintText: counterOfferPrice.toCurrencyWithoutSymbol(),
              readOnly: true,
              keyboardType: TextInputType.number,
              formatter: PriceInputFormatter(),
              prefixWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: theme.colors.neutral.light.three,
                  radius: 8.0,
                  child: DSText(
                    '\$',
                    customStyle: TextStyle(
                      fontSize: theme.font.size.xxs,
                      color: theme.colors.neutral.dark.two,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            DSText(
              CounterOfferResponseStrings.counterOfferResponseInfo,
              customStyle: TextStyle(
                fontSize: theme.font.size.xxxs,
                color: theme.colors.neutral.dark.two,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            BlocConsumer<OfferCubit, OfferState>(
              listener: (context, state) {
                if (state is OfferSuccess) {
                  appNavigator.pop();
                  appNavigator.pushRoute(
                    Routes.productPayment,
                    queryParameters: {
                      'purchaseType': 'counterOffer',
                      'productId': itemId,
                      'offerId': offerId,
                      'productOfferPrice': counterOfferPrice.toString(),
                    },
                  );
                } else if (state is OfferFailure) {
                  appNavigator.pop();
                  showDSBottomSheet(
                    context: context,
                    child: ErrorBottomSheetWidget(
                      message: state.message,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: DSButton(
                        label: CounterOfferResponseStrings.declineCounterOffer,
                        isLoading: state is OfferLoading,
                        onPressed: () {
                          context.read<OfferCubit>().declineCountOffer(offerId: offerId);
                        },
                        type: DSButtonType.ghost,
                      ),
                    ),
                    SizedBox(width: theme.spacing.inline.xs),
                    Expanded(
                      child: DSButton(
                        label: CounterOfferResponseStrings.acceptCounterOffer,
                        isLoading: state is OfferAcceptLoading,
                        onPressed: () async {
                          if (state is! OfferAcceptLoading) {
                            context.read<OfferCubit>().acceptCounterOffer(counterOfferId: offerId);
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: theme.spacing.inline.xs),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
