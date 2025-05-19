import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/commission_extension.dart';
import 'package:neighborhood_market/app/common/extensions/date_extension.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/common/formatter/price_formatter.dart';
import 'package:neighborhood_market/app/features/white_glove/domain/entity/white_glove_item_entity.dart';
import 'package:neighborhood_market/app/features/white_glove/utils/white_glove_strings.dart';

class WhiteGloveComponenteWidget extends StatefulWidget {
  const WhiteGloveComponenteWidget({
    required this.index,
    required this.whiteGloveItem,
    required this.onUpdate,
    required this.onRemove,
    this.isLoading = false,
    super.key,
  });

  final int index;
  final WhiteGloveItemEntity whiteGloveItem;
  final Function(WhiteGloveItemEntity item) onUpdate;
  final VoidCallback onRemove;
  final bool isLoading;

  @override
  State<WhiteGloveComponenteWidget> createState() => _WhiteGloveComponenteWidgetState();
}

class _WhiteGloveComponenteWidgetState extends State<WhiteGloveComponenteWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.whiteGloveItem.itemDescription ?? '';
    _priceController.text = widget.whiteGloveItem.price ?? '';
    _selectedDate = widget.whiteGloveItem.pickDate;
    _dateController.text = _selectedDate != null ? _selectedDate!.toStringDate() : '';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _priceController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _updatedItem() {
    final updatedItem = widget.whiteGloveItem.copyWith(
      itemDescription: _descriptionController.text,
      price: _priceController.text,
      pickDate: _selectedDate,
    );
    widget.onUpdate(updatedItem);
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.index > 0) ...[
          const ThemeDividerWidget(),
          SizedBox(height: theme.spacing.inline.xs),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DSText(
              WhiteGloveStrings.whiteGloveListingService(widget.index),
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            if (widget.index > 0)
              ClickableWidget(
                onTap: widget.onRemove,
                borderRadius: BorderRadius.circular(theme.borders.radius.circular),
                padding: EdgeInsets.all(theme.spacing.inline.xxs),
                child: const DSIcon(
                  icon: DSIcons.trashOutlined,
                  size: DSIconSize.sm,
                ),
              ),
          ],
        ),
        SizedBox(height: theme.spacing.inline.xs),
        TextInputLabelWidget(
          controller: _descriptionController,
          enabled: !widget.isLoading,
          onChanged: (_) => _updatedItem(),
          label: 'What’s the item?',
          hintText: 'Tell us what you\'re selling',
          validator: (description) {
            if (description == null || description.isEmpty) {
              return 'Please enter a description';
            }

            return null;
          },
        ),
        SizedBox(height: theme.spacing.inline.xs),
        TextInputLabelWidget(
          controller: _priceController,
          enabled: !widget.isLoading,
          label: 'Set your price',
          hintText: 'How much is it worth?',
          keyboardType: TextInputType.number,
          formatter: PriceInputFormatter(),
          onChanged: (_) => _updatedItem(),
          validator: (price) {
            if (price == null || price.isEmpty) {
              return 'Please enter a price';
            }

            return null;
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.inline.xxs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DSText(
                WhiteGloveStrings.whiteGloveCommissionValueLabel,
                customStyle: TextStyle(
                  fontSize: theme.font.size.xxxs,
                  fontWeight: theme.font.weight.regular,
                  color: theme.colors.neutral.dark.two,
                ),
              ),
              SizedBox(height: theme.spacing.inline.xxxs),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Final take home amount: ',
                      style: TextStyle(
                        fontSize: theme.font.size.xxxs,
                        fontWeight: theme.font.weight.regular,
                        color: theme.colors.neutral.dark.two,
                      ),
                    ),
                    TextSpan(
                      text: _priceController.text.parseToDouble().calculateWhiteGloveCommission().toCurrency(),
                      style: TextStyle(
                        fontSize: theme.font.size.xxxs,
                        fontWeight: theme.font.weight.semiBold,
                        color: theme.colors.neutral.dark.two,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: theme.spacing.inline.xs),
        TextInputLabelWidget(
          controller: _dateController,
          enabled: !widget.isLoading,
          label: 'When can we pick it up?',
          hintText: 'Select a date.',
          readOnly: true,
          validator: (_) {
            if (_selectedDate == null) {
              return 'Please select a date';
            }

            return null;
          },
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
            ).then((value) {
              if (value != null) {
                setState(() {
                  _selectedDate = value;
                  _dateController.text = _selectedDate!.toStringDate();
                });
                _updatedItem();
              }
            });
          },
        ),
        SizedBox(height: theme.spacing.inline.xs),
        DSText(
          'Please fill out the details below so we can assist you with your listing request',
          customStyle: TextStyle(
            fontSize: theme.font.size.xxxs,
            color: theme.colors.neutral.dark.two,
          ),
        ),
      ],
    );
  }
}
