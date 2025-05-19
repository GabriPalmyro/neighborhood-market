import 'package:equatable/equatable.dart';

class SearchModel extends Equatable {
  const SearchModel({
    required this.label,
    required this.leadingIcon,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      label: json['label'],
      leadingIcon: json['leadingIcon'],
    );
  }

  final String label;
  final String leadingIcon;

  @override
  List<Object> get props => [
        label,
        leadingIcon,
      ];
}
