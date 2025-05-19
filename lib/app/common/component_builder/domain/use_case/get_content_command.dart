import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_event.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component__content_request_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/component_content_strategy.dart';

abstract class GetContentCommand<T> {
  Future<T> execute(ComponentEvent event);
}

class GetContentCommandImpl<T> implements GetContentCommand<T> {
  GetContentCommandImpl(this._mapper, this._requestMapper, this._strategy);

  final ComponentContentMapper<T> _mapper;
  final ComponentContentRequestMapper _requestMapper;
  final ComponentContentStrategy _strategy;

  @override
  Future<T> execute(ComponentEvent event) async {
    final request = _requestMapper.mapToRequest(event);
    return await _strategy.execute(event, request).then((response) {
      if (response is SuccessResponse) {
        return _mapper.mapToContent(response.data);
      } else if(response is ErrorResponse) {
        throw Exception(response.error);
      } else {
        throw Exception('Unknown error');
      }
    });
  }
}
