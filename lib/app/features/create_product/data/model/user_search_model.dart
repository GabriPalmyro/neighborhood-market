import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/user_search_entity.dart';

class UserSearchModel extends Equatable {
  const UserSearchModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      id: json['id'],
      name: json['name'],
      email: json['email'] ?? '',
    );
  }

  final String id;
  final String name;
  final String email;

  UserSearchEntity toEntity() {
    return UserSearchEntity(
      id: id,
      name: name,
      email: email,
    );
  }

  @override
  List<Object> get props => [id, name, email];
}
