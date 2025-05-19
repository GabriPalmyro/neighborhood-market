import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_content_result.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_event.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component__content_request_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/component_content_strategy.dart';

abstract class ComponentContentCommand {
  Future<ComponentResult> execute(ComponentEvent event);
}

class ComponentContentCommandDefault extends ComponentContentCommand {
  ComponentContentCommandDefault(
    this._mapper,
    this._requestMapper,
    this._strategy,
  );

  final ComponentContentMapper<dynamic> _mapper;
  final ComponentContentRequestMapper _requestMapper;
  final ComponentContentStrategy _strategy;

  @override
  Future<ComponentResult> execute(ComponentEvent event) async {
    final request = _requestMapper.mapToRequest(event);
    return await _strategy.execute(event, request).then((response) {
      if (response is SuccessResponse) {
        return ContentSuccess(data: _mapper.mapToContent(response));
      } else if (response is ErrorResponse) {
        return ContentError(error: response.error, stackTrace: response.stackTrace);
      } else {
        throw UnimplementedError('Response not implemented');
      }
    });
  }
}
