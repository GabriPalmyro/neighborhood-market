import 'dart:developer';

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
import 'package:neighborhood_market/app/common/formatter/price_formatter.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/cubit/offer_cubit.dart';
import 'package:neighborhood_market/app/features/product/utils/product_strings.dart';

class OfferResponseBottomSheet extends StatefulWidget {
  const OfferResponseBottomSheet({
    required this.offerId,
    required this.offerPrice,
    required this.itemName,
    required this.itemId,
    super.key,
  });

  final String offerId;
  final double offerPrice;
  final String itemName;
  final String itemId;

  @override
  State<OfferResponseBottomSheet> createState() => _OfferResponseBottomSheetState();
}

class _OfferResponseBottomSheetState extends State<OfferResponseBottomSheet> {
  final TextEditingController _counterOfferController = TextEditingController();

  @override
  void dispose() {
    _counterOfferController.dispose();
    super.dispose();
  }

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
          MediaQuery.of(context).viewInsets.bottom + theme.spacing.inline.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSText(
              OfferResponseStrings.offerResponseTitle,
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            RichText(
              text: TextSpan(
                text: 'You\'ve received an offer for ',
                style: TextStyle(
                  fontSize: theme.font.size.xxs,
                  fontWeight: theme.font.weight.regular,
                  color: theme.colors.neutral.dark.two,
                  fontFamily: theme.font.family.base,
                ),
                children: [
                  TextSpan(
                    text: widget.itemName,
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
                            'id': widget.itemId,
                          },
                        );
                      },
                  ),
                  TextSpan(
                    text: '. You can now review the offer and either accept the price or submit a counteroffer.',
                    style: TextStyle(
                      fontFamily: theme.font.family.base,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            TextInputLabelWidget(
              label: 'Buyer\'s Offer Price',
              hintText: widget.offerPrice.toStringAsFixed(2),
              readOnly: true,
              keyboardType: TextInputType.number,
              formatter: PriceInputFormatter(),
              onChanged: (_) {
                log(_counterOfferController.text.toString());
                setState(() {});
              },
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
            TextInputLabelWidget(
              label: 'Enter your counter-offer',
              hintText: 'Make your proposal...',
              controller: _counterOfferController,
              keyboardType: TextInputType.number,
              formatter: PriceInputFormatter(),
              onChanged: (_) {
                setState(() {});
              },
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
              OfferResponseStrings.offerResponseInfo,
              customStyle: TextStyle(
                fontSize: theme.font.size.xxxs,
                color: theme.colors.neutral.dark.two,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            BlocConsumer<OfferCubit, OfferState>(
              listener: (context, state) {
                if (state is OfferSuccess) {
                  Navigator.of(context).pop();
                } else if (state is OfferFailure) {
                  Navigator.of(context).pop();
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
                        label: OfferResponseStrings.declineOffer,
                        isLoading: state is OfferDeclineLoading,
                        onPressed: () {
                          if (state is! OfferDeclineLoading) {
                            context.read<OfferCubit>().declineOffer(widget.offerId);
                          }
                        },
                        type: DSButtonType.ghost,
                      ),
                    ),
                    SizedBox(width: theme.spacing.inline.xs),
                    Expanded(
                      child: DSButton(
                        label: (_counterOfferController.text.isNotEmpty && _counterOfferController.text.parseToDouble() > 0.0) 
                        ? OfferResponseStrings.submitCounterOffer 
                        : OfferResponseStrings.acceptOffer,
                        isLoading: state is OfferLoading,
                        onPressed: () {
                          if (state is! OfferLoading) {
                            if (_counterOfferController.text.isNotEmpty && _counterOfferController.text.parseToDouble() > 0.0) {
                              context.read<OfferCubit>().makeCounterOffer(
                                    productId: widget.offerId,
                                    price: _counterOfferController.text.parseToDouble(),
                                  );
                            } else {
                              context.read<OfferCubit>().acceptOffer(
                                    widget.offerId,
                                  );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: theme.spacing.inline.xxs),
          ],
        ),
      ),
    );
  }
}
