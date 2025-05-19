import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/chips/chip_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/condiction_choice/choice_selector_widget.dart';
import 'package:neighborhood_market/app/features/create_product/utils/product_conditions.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/condiction_choice/condition_choice_widget.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/price_filter/price_filter_widget.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/sort_by_filter/sort_by_filter.dart';
import 'package:neighborhood_market/app/utils/data/sort_by_types.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        state as FiltersSelected;
        final filter = state.filters;
        return Scaffold(
          appBar: TopbarWidget.defaultTopBar(
            centerTitle: false,
            title: DSText(
              'Filters',
              customStyle: TextStyle(
                color: theme.colors.neutral.dark.three,
                fontSize: theme.font.size.xs,
                fontWeight: theme.font.weight.bold,
              ),
            ),
          ),
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.spacing.inline.xs,
                      vertical: theme.spacing.inline.xs,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PriceFilterWidget(
                          minPriceController: context.read<FilterCubit>().minPriceController,
                          maxPriceController: context.read<FilterCubit>().maxPriceController,
                        ),
                        SizedBox(height: theme.spacing.inline.sm),
                        SortByFilterWidget(
                          label: 'Sort by',
                          tooltip: 'Choose how to sort the products',
                          sorts: sortByTypes,
                          selectedId: state.filters.sortBy,
                          onTap: (sort) {
                            if (sort == filter.sortBy) {
                              context.read<FilterCubit>().setSortBy(null);
                            } else {
                              context.read<FilterCubit>().setSortBy(sort);
                            }
                          },
                        ),
                        SizedBox(height: theme.spacing.inline.sm),
                        ConditionsFilterChoiceWigdet(
                          label: 'Condition',
                          tooltip: 'Choose the condition of the products',
                          selectedIds: filter.conditions,
                          onTap: (condition) {
                            final conditions = List<String>.from(filter.conditions);

                            if (conditions.contains(condition)) {
                              conditions.remove(condition);
                            } else {
                              conditions.add(condition);
                            }

                            context.read<FilterCubit>().setConditions(conditions);
                          },
                        ),
                        SizedBox(height: theme.spacing.inline.sm),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: theme.spacing.inline.xxs,
                              ),
                              child: Tooltip(
                                message: 'Select the gender of the item',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    DSText(
                                      'Gender',
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
                            Wrap(
                              spacing: theme.spacing.inline.xxs,
                              runSpacing: theme.spacing.inline.xxs,
                              children: List.generate(
                                ProductGender.values.length,
                                (index) => ChipWidget(
                                  isSelected: filter.gender == ProductGender.values[index].value,
                                  label: ProductGender.values[index].label,
                                  onTap: () {
                                    if (filter.gender == ProductGender.values[index].value) {
                                      context.read<FilterCubit>().setGender(null);
                                      return;
                                    }

                                    context.read<FilterCubit>().setGender(ProductGender.values[index].value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: theme.spacing.inline.xs),
                        ChoiceSelectorWidget(
                          choices: productClothingSizes,
                          label: 'Clothing Size',
                          tooltip: 'Select the size of the item in clothing',
                          selectedId: filter.clothingSize ?? '',
                          onTap: (size) {
                            if (filter.clothingSize == size) {
                              context.read<FilterCubit>().setClothingSize(null);
                              return;
                            }

                            context.read<FilterCubit>().setClothingSize(size);
                          },
                        ),
                        SizedBox(height: theme.spacing.inline.xs),
                        ChoiceSelectorWidget(
                          choices: productShoeSizes,
                          label: 'Shoe Size',
                          tooltip: 'Select the size of the item in shoes',
                          selectedId: filter.shoeSize ?? '',
                          onTap: (size) {
                            if (filter.shoeSize == size) {
                              context.read<FilterCubit>().setShoeSize(null);
                              return;
                            }

                            context.read<FilterCubit>().setShoeSize(size);
                          },
                        ),
                        SizedBox(height: theme.spacing.inline.xxl),
                        SizedBox(height: theme.spacing.inline.xxl),
                        SizedBox(height: MediaQuery.of(context).padding.bottom),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(theme.spacing.inline.xs).copyWith(
                    bottom: theme.spacing.inline.xs + MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colors.neutral.light.one,
                    border: Border(
                      top: BorderSide(
                        color: theme.colors.neutral.light.two,
                        width: theme.borderWidth.thin,
                      ),
                    ),
                  ),
                  child: DSButton(
                    label: 'Apply',
                    onPressed: () {
                      if (filter.isMinPriceHigherThanMaxPrice()) {
                        ScaffoldMessenger.of(context).showErrorSnackBar(
                          context,
                          content: 'The minimum price must be less than the maximum price',
                        );
                        return;
                      }

                      Navigator.of(context).pop();
                      context.read<FilterCubit>().applyFilters();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
