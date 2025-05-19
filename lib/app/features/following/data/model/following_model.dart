import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/following/domain/entities/following_entity.dart';

class FollowingModel extends Equatable {
  const FollowingModel({
    required this.id,
    required this.username,
    required this.photo,
    this.isChecked = false,
    this.isFollowing = false,
    this.availableItem = 0,
  });

  factory FollowingModel.fromJson(Map<String, dynamic> json) {
    return FollowingModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      photo: json['profile_pic'] ?? '',
      isChecked: json['isChecked'] ?? false,
      isFollowing: json['isFollowing'] ?? true,
      availableItem: json['availableItems'] ?? 0,
    );
  }

  final String id;
  final String username;
  final String photo;
  final bool isChecked;
  final bool isFollowing;
  final int availableItem;

  FollowingEntity toEntity() {
    return FollowingEntity(
      id: id,
      username: username,
      photo: photo,
      isChecked: isChecked,
      isFollowing: isFollowing,
      availableItem: availableItem,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        photo,
        isChecked,
        isFollowing,
        availableItem,
      ];
}
