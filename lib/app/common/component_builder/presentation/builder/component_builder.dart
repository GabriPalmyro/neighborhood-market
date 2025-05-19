import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';

abstract class ComponentBuilder<T extends Widget> {
  Widget create(WidgetModel model);
}
