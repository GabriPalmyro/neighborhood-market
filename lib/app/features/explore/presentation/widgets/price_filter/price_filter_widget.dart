import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text_field/text_field_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/formatter/price_formatter.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart';

class PriceFilterWidget extends StatelessWidget {
  const PriceFilterWidget({
    required this.minPriceController,
    required this.maxPriceController,
    super.key,
  });

  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.inline.xxs,
          ),
          child: Tooltip(
            message: 'Set the price range you want to filter',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DSText(
                  'Price',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xxs,
                    fontWeight: theme.font.weight.medium,
                  ),
                ),
                SizedBox(width: theme.spacing.inline.xxxs),
                const Icon(
                  Icons.info_outline,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: theme.spacing.inline.xxs),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: theme.spacing.inline.xxs,
                ),
                child: DSTextField(
                  controller: minPriceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [PriceInputFormatter()],
                  label: 'Min',
                  hintText: 'Min',
                  onChanged: (value) {
                    context.read<FilterCubit>().selectFilters(
                          minPrice: value.parseToDouble(),
                        );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: theme.spacing.inline.xxs,
                ),
                child: DSTextField(
                  controller: maxPriceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [PriceInputFormatter()],
                  label: 'Max',
                  hintText: 'Max',
                  onChanged: (value) {
                    context.read<FilterCubit>().selectFilters(
                          maxPrice: value.parseToDouble(),
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
