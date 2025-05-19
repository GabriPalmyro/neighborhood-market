import 'package:equatable/equatable.dart';

class FiltersModel extends Equatable {
  const FiltersModel({
    this.title,
    this.actionLabel,
    this.items,
  });

  factory FiltersModel.fromJson(Map<String, dynamic> json) {
    return FiltersModel(
      title: json['title'],
      actionLabel: json['actionLabel'],
      items: (json['items'] as List).map((item) => FilterItemModel.fromJson(item)).toList(),
    );
  }

  final String? title;
  final String? actionLabel;
  final List<FilterItemModel>? items;

  @override
  List<Object?> get props => [
        title,
        actionLabel,
        items,
      ];
}

class FilterItemModel extends Equatable {
  const FilterItemModel({
    this.label,
    this.image,
    this.value,
    this.type,
  });

  factory FilterItemModel.fromJson(Map<String, dynamic> json) {
    return FilterItemModel(
      label: json['label'],
      image: json['image'],
      value: json['value'],
      type: json['type'],
    );
  }

  final String? label;
  final String? image;
  final String? value;
  final String? type;

  @override
  List<Object?> get props => [
        label,
        image,
        value,
        type,
      ];
}
