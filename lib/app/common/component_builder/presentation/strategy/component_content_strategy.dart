import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_event.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';

abstract class ComponentContentStrategy {
  Future<ComponentResponse> execute(ComponentEvent event, ComponentRequest request);
}