part of 'user_selection_cubit.dart';

sealed class UserSelectionState extends Equatable {
  const UserSelectionState();

  @override
  List<Object> get props => [];
}

final class UserSelectionInitial extends UserSelectionState {
  const UserSelectionInitial();

  @override
  List<Object> get props => [];
}

final class UserSelectionLoading extends UserSelectionState {
  const UserSelectionLoading();

  @override
  List<Object> get props => [];
}

final class UserSelectionLoaded extends UserSelectionState {
  const UserSelectionLoaded(
    {
    required this.users,
    this.currentPage = 1,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });
  final List<UserSearchEntity> users;
  final int currentPage;
  final bool isLoadingMore;
  final bool hasReachedMax;

  UserSelectionLoaded copyWith({
    List<UserSearchEntity>? users,
    int? currentPage,
    bool? isLoadingMore,
    bool? hasReachedMax,
  }) {
    return UserSelectionLoaded(
      users: users ?? this.users,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        users,
        currentPage,
        isLoadingMore,
        hasReachedMax,
      ];
}

final class UserSelectionError extends UserSelectionState {
  const UserSelectionError(this.message);
  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}
