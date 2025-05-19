import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter.dart';

abstract class ComponentsPageFactory {
  ComponentsPageFactory();
  late ComponentContentAdapter adapter;
  void addAdapter(ComponentContentAdapter adapter);
  Widget create([dynamic params]);
}
