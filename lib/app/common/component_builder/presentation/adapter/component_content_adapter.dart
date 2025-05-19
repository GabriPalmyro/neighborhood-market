import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';

abstract class ComponentContentAdapter {
  const ComponentContentAdapter({required this.builders});

  final HashMap<String, Widget Function(WidgetModel model)> builders;

  Widget bindWidget(WidgetModel model);
}

class ComponentContentAdapterImpl extends ComponentContentAdapter {
  const ComponentContentAdapterImpl({required super.builders});

  @override
  Widget bindWidget(WidgetModel model) {
    return builders[model.id]?.call(model) ?? const SizedBox();
  }
}
