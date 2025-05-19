part of 'category_selection_cubit.dart';

sealed class CategorySelectionState extends Equatable {
  const CategorySelectionState();

  @override
  List<Object> get props => [];
}

final class CategorySelectionInitial extends CategorySelectionState {
  const CategorySelectionInitial();

  @override
  List<Object> get props => [];
}

final class CategorySelectionLoading extends CategorySelectionState {
  const CategorySelectionLoading();

  @override
  List<Object> get props => [];
}

final class CategorySelectionLoaded extends CategorySelectionState {
  const CategorySelectionLoaded({
    this.categories = const [],
    this.navigationPath = const [],
  });

  final List<CategoryEntity> categories;
  final List<CategoryEntity> navigationPath;

  CategorySelectionLoaded copyWith({
    List<CategoryEntity>? categories,
    List<CategoryEntity>? navigationPath,
  }) {
    return CategorySelectionLoaded(
      categories: categories ?? this.categories,
      navigationPath: navigationPath ?? this.navigationPath,
    );
  }

  @override
  List<Object> get props => [categories, navigationPath];
}

final class CategorySelectionError extends CategorySelectionState {
  const CategorySelectionError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
