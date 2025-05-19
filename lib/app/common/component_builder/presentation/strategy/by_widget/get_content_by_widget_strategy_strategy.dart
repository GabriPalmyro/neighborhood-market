import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';

abstract class GetContentByWidgetStrategy {
  bool isApplicable(WidgetModel model);
  Future<ComponentResponse> execute(WidgetModel model, ComponentRequest request);
}