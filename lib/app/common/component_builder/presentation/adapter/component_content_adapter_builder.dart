import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter.dart';

abstract class ComponentContentAdapterBuilder {
  abstract HashMap<String, Widget Function(WidgetModel model)> builders;

  void addBuilder(String name, Widget Function(WidgetModel model) builder) {
    builders[name] = builder;
  }

  ComponentContentAdapter build();
}

class ComponentContentAdapterBuilderImpl extends ComponentContentAdapterBuilder {
  ComponentContentAdapterBuilderImpl();

  @override
  HashMap<String, Widget Function(WidgetModel model)> builders = HashMap();

  @override
  ComponentContentAdapter build() {
    return ComponentContentAdapterImpl(builders: builders);
  }
}
