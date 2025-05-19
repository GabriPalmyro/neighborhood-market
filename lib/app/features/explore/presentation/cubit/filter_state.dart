part of 'filter_cubit.dart';

sealed class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object?> get props => [];
}

final class FiltersSelected extends FilterState {
  const FiltersSelected({
    this.filters = const FilterEntity(),
  });

  final FilterEntity filters;

  FiltersSelected copyWith({
    List<String>? conditions,
    String? sortBy,
    String? category,
    double? minPrice,
    double? maxPrice,
    String? gender,
    String? clothingSize,
    String? shoeSize,
  }) {
    return FiltersSelected(
      filters: filters.copyWith(
        conditions: conditions ?? filters.conditions,
        sortBy: sortBy ?? filters.sortBy,
        category: category ?? filters.category,
        minPrice: minPrice ?? filters.minPrice,
        maxPrice: maxPrice ?? filters.maxPrice,
        gender: gender ?? filters.gender,
        clothingSize: clothingSize ?? filters.clothingSize,
        shoeSize: shoeSize ?? filters.shoeSize,
      ),
    );
  }

  @override
  List<Object?> get props => [filters];
}
