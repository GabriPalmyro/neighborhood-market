import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component__content_request_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/component_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/component_content_strategy.dart';

abstract class ComponentContentCommandFactory {
  const ComponentContentCommandFactory();

  void addMapper(ComponentContentMapper<dynamic> mapper);
  void addRequestMapper(ComponentContentRequestMapper mapper);
  void addStrategy(ComponentContentStrategy strategy);
  ComponentContentCommand create();
}

class ComponentContentCommandFactoryDefault extends ComponentContentCommandFactory {
  ComponentContentCommandFactoryDefault();

  late ComponentContentMapper<dynamic> _mapper;
  late ComponentContentRequestMapper _requestMapper;
  late final ComponentContentStrategy _strategy;

  @override
  void addMapper(ComponentContentMapper<dynamic> mapper) {
    _mapper = mapper;
  }

  @override
  void addRequestMapper(ComponentContentRequestMapper mapper) {
    _requestMapper = mapper;
  }

  @override
  void addStrategy(ComponentContentStrategy strategy) {
    _strategy = strategy;
  }

  @override
  ComponentContentCommand create() {
    return ComponentContentCommandDefault(
      _mapper,
      _requestMapper,
      _strategy,
    );
  }
}
