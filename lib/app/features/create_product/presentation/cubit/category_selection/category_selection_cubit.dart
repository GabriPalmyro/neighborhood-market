import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/create_product/domain/boundary/create_product_repository.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';

part 'category_selection_state.dart';

@injectable
class CategorySelectionCubit extends Cubit<CategorySelectionState> {
  CategorySelectionCubit(this.repository) : super(const CategorySelectionInitial());

  final CreateProductRepository repository;

  Future<void> loadCategories() async {
    emit(const CategorySelectionLoading());
    try {
      final categories = await repository.getCategories();
      emit(CategorySelectionLoaded(categories: categories));
    } catch (e) {
      emit(CategorySelectionError(e.toString()));
    }
  }

  void selectCategory(CategoryEntity category) {
    if (state is CategorySelectionLoaded) {
      final currentState = state as CategorySelectionLoaded;
      // Se a categoria tem subcategorias, adicione-a ao caminho e emita o novo estado
      if (category.subcategories?.isNotEmpty == true) {
        CategoryEntity addCategory = category;

        if (currentState.navigationPath.isEmpty) {
          addCategory = addCategory.copyWith(type: CategoryType.fromString(category.name));
        } else {
          addCategory = addCategory.copyWith(type: currentState.navigationPath.last.type);
        }

        final updatedPath = List<CategoryEntity>.from(currentState.navigationPath)
          ..add(
            addCategory,
          );
        emit(currentState.copyWith(navigationPath: updatedPath));
      }
    }
  }

  void goBack() {
    final currentState = state as CategorySelectionLoaded;
    if (currentState.navigationPath.isNotEmpty) {
      final updatedPath = List<CategoryEntity>.from(currentState.navigationPath)..removeLast();
      emit(currentState.copyWith(navigationPath: updatedPath));
    }
  }

  void reset() {
    if (state is! CategorySelectionLoaded) {
      return;
    }

    emit((state as CategorySelectionLoaded).copyWith(navigationPath: []));
  }
}
