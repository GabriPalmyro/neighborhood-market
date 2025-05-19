import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_event.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/by_widget/get_content_by_widget_strategy_strategy.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/component_content_strategy.dart';

class ComponentContentByWidgetStrategy extends ComponentContentStrategy {
  ComponentContentByWidgetStrategy(Set<GetContentByWidgetStrategy> strategies) : _strategies = strategies;
  final Set<GetContentByWidgetStrategy> _strategies;

  @override
  Future<ComponentResponse> execute(ComponentEvent event, ComponentRequest request) async {
    event as GetContentEvent;
    final resolver = _getStrategy(event);
    if(resolver != null) {
      return await resolver.execute(event.content, request);
    }
    throw Exception('No strategy found for ${event.content.runtimeType}');
  }

  GetContentByWidgetStrategy? _getStrategy(GetContentEvent event) {
    GetContentByWidgetStrategy? resolver;
    for (final strategy in _strategies) {
      if(strategy.isApplicable(event.content)) {
        resolver = strategy;
        break;
      }
    }
    return resolver;
  }
}
