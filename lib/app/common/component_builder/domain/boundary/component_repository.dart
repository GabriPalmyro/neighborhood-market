import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';

abstract class ComponentRepository {
  const ComponentRepository();
  Future<ComponentResponse> getContent(ComponentRequest request);
}