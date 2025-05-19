import 'package:equatable/equatable.dart';

class MyProfileEntity extends Equatable {
  const MyProfileEntity({
    this.username,
    this.fullName,
    this.image,
    this.background,
    this.email,
    this.phone,
    this.biography,
  });

  final String? username;
  final String? fullName;
  final String? image;
  final String? background;
  final String? email;
  final String? phone;
  final String? biography;

  MyProfileEntity copyWith({
    String? username,
    String? fullName,
    String? image,
    String? background,
    String? email,
    String? phone,
    String? biography,
  }) {
    return MyProfileEntity(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      image: image ?? this.image,
      background: background ?? this.background,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      biography: biography ?? this.biography,
    );
  }

  @override
  List<Object?> get props => [
        username,
        fullName,
        image,
        background,
        email,
        phone,
        biography,
      ];
}
