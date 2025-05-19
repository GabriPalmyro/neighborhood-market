import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';

abstract class ComponentEvent extends Equatable {
  const ComponentEvent();
}

class GetContentEvent extends ComponentEvent {
  const GetContentEvent({
    required this.content,
  });

  final WidgetModel content;

  @override
  List<Object?> get props => [
    content,
  ];
}