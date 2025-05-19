import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';

class ProfileActionsSectionsModel extends Equatable {
  const ProfileActionsSectionsModel({
    required this.title,
    required this.items,
  });

  factory ProfileActionsSectionsModel.fromJson(Map<String, dynamic> json) {
    return ProfileActionsSectionsModel(
      title: json['title'],
      items: List<ProfileActionsItemsModel>.from(
        json['items'].map(
          (x) => ProfileActionsItemsModel.fromJson(x),
        ),
      ),
    );
  }

  final String title;
  final List<ProfileActionsItemsModel> items;

  @override
  List<Object> get props => [
        title,
        items,
      ];
}

class ProfileActionsItemsModel extends Equatable {
  const ProfileActionsItemsModel({
    required this.title,
    this.icon,
    this.route,
    this.isLogout = false,
    this.params,
  });

  factory ProfileActionsItemsModel.fromJson(Map<String, dynamic> json) {
    return ProfileActionsItemsModel(
      title: json['title'],
      icon: json['icon'],
      route: null,
      isLogout: json['isLogout'],
      params: json['params'],
    );
  }

  final String title;
  final String? icon;
  final Routes? route;
  final Map<String, String>? params;
  final bool isLogout;

  @override
  List<Object?> get props => [
        title,
        icon,
        route,
        isLogout,
        params,
      ];
}
