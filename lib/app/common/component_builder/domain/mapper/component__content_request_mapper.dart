import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_event.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';

abstract class ComponentContentRequestMapper {
  const ComponentContentRequestMapper();
  ComponentRequest mapToRequest(ComponentEvent event);
}

class LoadContentRequestMapper extends ComponentContentRequestMapper {
  const LoadContentRequestMapper();

  @override
  ComponentRequest mapToRequest(ComponentEvent event) {
    if (event is GetContentEvent) {
      return LoadContentRequest(endpoint: event.content.path);
    }

    throw UnimplementedError('Event not implemented');
  }
}
