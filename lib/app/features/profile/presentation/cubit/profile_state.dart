import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();

  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded(
    this.id,
    this.name,
    this.description,
    this.image,
    this.background,
  );

  final String id;
  final String name;
  final String description;
  final String? image;
  final String? background;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        background,
      ];
}

class ProfileError extends ProfileState {
  const ProfileError();

  @override
  List<Object> get props => [];
}
