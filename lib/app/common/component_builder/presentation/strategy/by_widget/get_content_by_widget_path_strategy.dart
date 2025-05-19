import 'package:neighborhood_market/app/common/component_builder/domain/boundary/component_repository.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_state.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/by_widget/get_content_by_widget_strategy_strategy.dart';

class GetContentByWidgetPathStrategy extends GetContentByWidgetStrategy {
  GetContentByWidgetPathStrategy(
    this._repository,
  );

  final ComponentRepository _repository;

  @override
  Future<ComponentResponse> execute(WidgetModel model, ComponentRequest request) async {
    return _repository.getContent(request);
  }

  @override
  bool isApplicable(WidgetModel model) {
    return model.state == WidgetState.loading;
  }
}
