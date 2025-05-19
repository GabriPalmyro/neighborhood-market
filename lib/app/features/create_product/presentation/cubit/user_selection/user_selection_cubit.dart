import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/create_product/domain/boundary/create_product_repository.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/user_search_entity.dart';

part 'user_selection_state.dart';

@injectable
class UserSelectionCubit extends Cubit<UserSelectionState> {
  UserSelectionCubit(this.repository) : super(const UserSelectionInitial());

  final CreateProductRepository repository;

  static const int _pageSize = 10;
  static const int _initialPage = 1;
  String _currentQuery = '';

  Future<void> searchUsers(
    String name, {
    int page = _initialPage,
    bool isLoadMore = false,
  }) async {
    try {
      if (isLoadMore) {
        final currentState = state;
        if (currentState is UserSelectionLoaded && currentState.isLoadingMore) {
          return;
        }
        emit((state as UserSelectionLoaded).copyWith(isLoadingMore: true));
      } else {
        _currentQuery = name;
        emit(const UserSelectionLoading());
      }

      final newUsers = await repository.searchUsers(
        name,
        page,
      );

      if (isLoadMore) {
        final currentState = state;
        if (currentState is UserSelectionLoaded) {
          emit(
            currentState.copyWith(
              users: [...currentState.users, ...newUsers],
              currentPage: page,
              hasReachedMax: newUsers.length < _pageSize,
              isLoadingMore: false,
            ),
          );
        }
      } else {
        emit(
          UserSelectionLoaded(
            users: newUsers,
            currentPage: page,
            hasReachedMax: newUsers.length < _pageSize,
          ),
        );
      }
    } catch (e) {
      if (isLoadMore) {
        final currentState = state;
        if (currentState is UserSelectionLoaded) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } else {
        emit(UserSelectionError(e.toString()));
      }
    }
  }

  void loadMore() {
    final currentState = state;
    if (currentState is UserSelectionLoaded && !currentState.hasReachedMax) {
      searchUsers(_currentQuery, page: currentState.currentPage + 1, isLoadMore: true);
    }
  }
}
