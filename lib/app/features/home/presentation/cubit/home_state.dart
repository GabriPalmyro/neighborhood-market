import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/home/domain/entities/home_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.entity);
  final HomeEntity entity;

  HomeLoaded copyWith({
    HomeEntity? entity,
  }) {
    return HomeLoaded(
      entity ?? this.entity,
    );
  }

  @override
  List<Object> get props => [
        entity,
      ];
}

class HomeError extends HomeState {
  const HomeError();

  @override
  List<Object> get props => [];
}
