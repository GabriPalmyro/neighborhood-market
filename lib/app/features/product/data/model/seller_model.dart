import 'package:neighborhood_market/app/features/product/domain/entities/seller_entity.dart';

class SellerModel extends SellerEntity {
  const SellerModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.description,
    required super.isFollowing,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      isFollowing: json['isFollowing'] ?? false,
    );
  }

  SellerEntity toEntity() {
    return SellerEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      description: description,
      isFollowing: isFollowing,
    );
  }
}
