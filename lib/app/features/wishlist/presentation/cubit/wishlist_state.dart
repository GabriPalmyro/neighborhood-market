import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/wishlist/domain/entities/wishlist_entity.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();

  @override
  List<Object> get props => [];
}

class WishlistLoading extends WishlistState {
  const WishlistLoading();

  @override
  List<Object> get props => [];
}

class WishlistLoaded extends WishlistState {
  const WishlistLoaded(this.entity);
  final WishlistEntity entity;

  WishlistLoaded copyWith({
   WishlistEntity? entity,
  }) {
    return WishlistLoaded(
      entity ?? this.entity,
    );
  }

  @override
  List<Object> get props => [
        entity,
      ];
}

class WishlistError extends WishlistState {
  const WishlistError();

  @override
  List<Object> get props => [];
}
