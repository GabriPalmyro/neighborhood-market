import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_header_entity.dart';

class SellerHeaderModel extends Equatable {
  const SellerHeaderModel({
    required this.username,
    required this.imageProfile,
    required this.imageBackground,
    this.description,
    this.isFollowing = false,
  });

  factory SellerHeaderModel.fromJson(Map<String, dynamic> json) {
    return SellerHeaderModel(
      username: json['username'],
      imageProfile: json['image'],
      imageBackground: json['background'],
      description: json['description'],
      isFollowing: json['isFollowing'] ?? false,
    );
  }

  final String username;
  final String imageProfile;
  final String? description;
  final String? imageBackground;
  final bool isFollowing;

  SellerHeaderEntity toEntity() {
    return SellerHeaderEntity(
      username: username,
      imageProfile: imageProfile,
      imageBackground: imageBackground,
      description: description,
      isFollowing: isFollowing
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
