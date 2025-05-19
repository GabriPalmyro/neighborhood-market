import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/by_widget/get_content_by_widget_strategy_strategy.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/component_content_by_widget_strategy.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/component_content_strategy.dart';

abstract class ComponentContentByWidgetStrategyFactory {
  void addStrategy(GetContentByWidgetStrategy strategy);
  ComponentContentStrategy create();
}

class DefaultComponentContentByWidgetStrategyFactory implements ComponentContentByWidgetStrategyFactory {
  final Set<GetContentByWidgetStrategy> _strategies = {};

  @override
  void addStrategy(GetContentByWidgetStrategy strategy) {
    _strategies.add(strategy);
  }

  @override
  ComponentContentStrategy create() {
    return ComponentContentByWidgetStrategy(_strategies);
  }
}
