import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';

abstract class ComponentDataSource {
  Future<ComponentResponse> getContent({required ComponentRequest request});
}