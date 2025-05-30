import 'package:equatable/equatable.dart';

class UserSearchEntity extends Equatable {
  const UserSearchEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  final String id;
  final String name;
  final String email;

  @override
  List<Object> get props => [id, name, email];
}
