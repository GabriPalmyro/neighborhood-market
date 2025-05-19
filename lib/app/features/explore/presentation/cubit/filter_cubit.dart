import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/features/explore/data/repository/filter_update_repository.dart';
import 'package:neighborhood_market/app/features/explore/domain/entity/filter_entity.dart';
import 'package:neighborhood_market/app/utils/data/sort_by_types.dart';

part 'filter_state.dart';

@injectable
class FilterCubit extends Cubit<FilterState> {
  FilterCubit(this.filterUpdate) : super(const FiltersSelected());

  final FilterUpdateRepository filterUpdate;

  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  void selectFilters({
    List<String>? conditions,
    String? sortBy,
    double? minPrice,
    double? maxPrice,
    String? category,
    String? gender,
    String? clothingSize,
    String? shoeSize,
  }) {
    final String sortBySelected = sortByTypes.firstWhere(
      (element) => element.replaceAll(' ', '') == sortBy,
      orElse: () => '',
    );

    emit(
      (state as FiltersSelected).copyWith(
        conditions: conditions,
        sortBy: sortBySelected,
        minPrice: minPrice,
        maxPrice: maxPrice,
        category: category,
        gender: gender,
        clothingSize: clothingSize,
        shoeSize: shoeSize,
      ),
    );

    if (minPrice != null) {
      minPriceController.text = minPrice.toCurrency();
    }

    if (maxPrice != null) {
      maxPriceController.text = maxPrice.toCurrency();
    }
  }

  void setConditions(List<String> conditions) {
    emit((state as FiltersSelected).copyWith(conditions: conditions));
  }

  void setSortBy(String? sortBy) {
    final oldState = state as FiltersSelected;
    emit(oldState.copyWith(sortBy: sortBy));
  }

  void setMinPrice(double minPrice) {
    emit((state as FiltersSelected).copyWith(minPrice: minPrice));
    minPriceController.text = minPrice.toCurrency();
  }

  void setMaxPrice(double maxPrice) {
    emit((state as FiltersSelected).copyWith(maxPrice: maxPrice));
    maxPriceController.text = maxPrice.toCurrency();
  }

  void setCategory(String category) {
    emit((state as FiltersSelected).copyWith(category: category));
  }

  void setGender(String? gender) {
    emit(
      FiltersSelected(
        filters: FilterEntity(
          maxPrice: (state as FiltersSelected).filters.maxPrice,
          minPrice: (state as FiltersSelected).filters.minPrice,
          category: (state as FiltersSelected).filters.category,
          conditions: (state as FiltersSelected).filters.conditions,
          sortBy: (state as FiltersSelected).filters.sortBy,
          clothingSize: (state as FiltersSelected).filters.clothingSize,
          gender: gender,
          shoeSize: (state as FiltersSelected).filters.shoeSize,
          search: (state as FiltersSelected).filters.search,
        ),
      ),
    );
  }

  void setClothingSize(String? clothingSize) {
    emit(
      FiltersSelected(
        filters: FilterEntity(
          maxPrice: (state as FiltersSelected).filters.maxPrice,
          minPrice: (state as FiltersSelected).filters.minPrice,
          category: (state as FiltersSelected).filters.category,
          conditions: (state as FiltersSelected).filters.conditions,
          sortBy: (state as FiltersSelected).filters.sortBy,
          clothingSize: clothingSize,
          gender: (state as FiltersSelected).filters.gender,
          shoeSize: (state as FiltersSelected).filters.shoeSize,
          search: (state as FiltersSelected).filters.search,
        ),
      ),
    );
  }

  void setShoeSize(String? shoeSize) {
    emit(
      FiltersSelected(
        filters: FilterEntity(
          maxPrice: (state as FiltersSelected).filters.maxPrice,
          minPrice: (state as FiltersSelected).filters.minPrice,
          category: (state as FiltersSelected).filters.category,
          conditions: (state as FiltersSelected).filters.conditions,
          sortBy: (state as FiltersSelected).filters.sortBy,
          clothingSize: (state as FiltersSelected).filters.clothingSize,
          gender: (state as FiltersSelected).filters.gender,
          shoeSize: shoeSize,
          search: (state as FiltersSelected).filters.search,
        ),
      ),
    );
  }

  void applyFilters() {
    filterUpdate.updateFilter(state);
  }
}
