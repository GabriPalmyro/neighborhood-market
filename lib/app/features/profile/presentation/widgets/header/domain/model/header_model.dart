import 'package:equatable/equatable.dart';

class HeaderModel extends Equatable {
  const HeaderModel({
    this.username,
    this.imageProfile,
    this.imageBackground,
    this.description,
    this.isFollowing,
  });

  factory HeaderModel.fromJson(Map<String, dynamic> json) {
    return HeaderModel(
      username: json['username'],
      imageProfile: json['profile_pic'],
      imageBackground: json['background'],
      description: json['description'],
      isFollowing: json['is_following'],
    );
  }

  final String? username;
  final String? imageProfile;
  final String? imageBackground;
  final String? description;
  final bool? isFollowing;

  @override
  List<Object?> get props => [
        username,
        imageProfile,
        imageBackground,
        description,
        isFollowing,
      ];
}
