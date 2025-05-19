import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/entities/my_profile_entity.dart';

class MyProfileModel extends Equatable {
  const MyProfileModel({
    this.username,
    this.fullName,
    this.image,
    this.background,
    this.email,
    this.phone,
    this.biography,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) {
    return MyProfileModel(
      username: json['username'],
      fullName: json['name'],
      image: json['profile_pic'],
      background: json['background'],
      email: json['email'],
      phone: json['phone'],
      biography: json['bio'],
    );
  }

  final String? username;
  final String? fullName;
  final String? image;
  final String? background;
  final String? email;
  final String? phone;
  final String? biography;

  MyProfileEntity toEntity() {
    return MyProfileEntity(
      username: username,
      fullName: fullName,
      image: image,
      background: background,
      email: email,
      phone: phone,
      biography: biography,
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
