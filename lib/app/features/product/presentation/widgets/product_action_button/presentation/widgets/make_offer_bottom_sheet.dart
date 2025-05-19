import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/formatter/price_formatter.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/cubit/offer_cubit.dart';
import 'package:neighborhood_market/app/features/product/utils/product_strings.dart';

class MakeOfferBottomSheet extends StatefulWidget {
  const MakeOfferBottomSheet({required this.productId, super.key});
  final String productId;

  @override
  State<MakeOfferBottomSheet> createState() => _MakeOfferBottomSheetState();
}

class _MakeOfferBottomSheetState extends State<MakeOfferBottomSheet> {
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (_) => GetIt.I.get<OfferCubit>(),
      child: BlocConsumer<OfferCubit, OfferState>(
        listener: (context, state) {
          if (state is OfferSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSuccessSnackBar(
              context,
              content: ProductStrings.offerSentSuccessfully,
            );
          } else if (state is OfferFailure) {
            Navigator.of(context).pop();
            showDSBottomSheet(
              context: context,
              isScrollControlled: false,
              child: ErrorBottomSheetWidget(
                message: state.message,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
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
                  'Making an Offer',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    fontWeight: theme.font.weight.bold,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxxs),
                DSText(
                  'You\'re about to submit an offer. Please make sure your offer is fair and reasonable for both parties',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    fontWeight: theme.font.weight.regular,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xxs),
                TextInputLabelWidget(
                  label: 'Offer Price',
                  hintText: 'Make your proposal',
                  controller: _priceController,
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
                  'After submitting, the seller will have 48 hours to review and respond to your offer. Thank you for your patience during this process.',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxxs,
                    color: theme.colors.neutral.dark.two,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xs),
                BlocBuilder<OfferCubit, OfferState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: DSButton(
                            label: 'Cancel',
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            type: DSButtonType.ghost,
                          ),
                        ),
                        SizedBox(width: theme.spacing.inline.xs),
                        Expanded(
                          child: DSButton(
                            label: 'Submit',
                            isLoading: state is OfferLoading,
                            onPressed: () async {
                              context.read<OfferCubit>().makeOffer(
                                    productId: widget.productId,
                                    price: _priceController.text.parseToDouble(),
                                  );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: theme.spacing.inline.sm),
              ],
            ),
          );
        },
      ),
    );
  }
}
