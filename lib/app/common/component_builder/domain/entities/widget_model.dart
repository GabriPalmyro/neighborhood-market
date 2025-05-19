import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_style.dart';

import 'widget_state.dart';

class WidgetModel extends Equatable {
  const WidgetModel({
    required this.id,
    required this.state,
    required this.path,
    required this.data,
    this.style,
  });

  factory WidgetModel.fromJson(Map<String, dynamic> json) {
    return WidgetModel(
      id: json['id'],
      state: WidgetState.getByName(json['state']),
      path: json['path'],
      data: json['data'],
      style: json['style'] != null ? WidgetStyle.fromMap(json['style']) : null,
    );
  }

  final String id;
  final WidgetState state;
  final String path;
  final dynamic data;
  final WidgetStyle? style;

  @override
  List<Object?> get props => [
        id,
        state,
        path,
        data,
        style,
      ];
}
