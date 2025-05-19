import 'package:equatable/equatable.dart';

class SellerEntity extends Equatable {
  const SellerEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.isFollowing,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String? description;
  final bool isFollowing;

  SellerEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    bool? isFollowing,
  }) {
    return SellerEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        description,
        isFollowing,
      ];
}
