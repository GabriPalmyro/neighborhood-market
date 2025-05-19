import 'package:equatable/equatable.dart';

class SellerHeaderEntity extends Equatable {
  const SellerHeaderEntity({
    required this.username,
    required this.imageProfile,
    required this.imageBackground,
    this.description,
    this.isFollowing = false,
  });

  final String username;
  final String imageProfile;
  final String? description;
  final String? imageBackground;
  final bool isFollowing;

  SellerHeaderEntity copyWith({
    String? username,
    String? imageProfile,
    String? imageBackground,
    String? description,
    bool? isFollowing,
  }) {
    return SellerHeaderEntity(
      username: username ?? this.username,
      imageProfile: imageProfile ?? this.imageProfile,
      imageBackground: imageBackground ?? this.imageBackground,
      description: description ?? this.description,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  @override
  List<Object?> get props => [
        username,
        imageProfile,
        imageBackground,
        description,
        isFollowing,
      ];
}
