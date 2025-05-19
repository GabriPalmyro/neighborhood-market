import 'package:equatable/equatable.dart';

class FollowingEntity extends Equatable {
  const FollowingEntity({
    required this.id,
    required this.username,
    required this.photo,
    this.isChecked = false,
    this.isFollowing = true,
    this.availableItem = 0,
  });

  final String id;
  final String username;
  final String photo;
  final bool isChecked;
  final bool isFollowing;
  final int availableItem;

  FollowingEntity copyWith({
    String? id,
    String? username,
    String? photo,
    bool? isChecked,
    bool? isFollowing,
    int? availableItem,
  }) {
    return FollowingEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      photo: photo ?? this.photo,
      isChecked: isChecked ?? this.isChecked,
      isFollowing: isFollowing ?? this.isFollowing,
      availableItem: availableItem ?? this.availableItem,
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
