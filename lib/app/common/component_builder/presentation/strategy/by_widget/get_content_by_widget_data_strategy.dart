import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_state.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/by_widget/get_content_by_widget_strategy_strategy.dart';

class GetContentByWidgetDataStrategy extends GetContentByWidgetStrategy {
  GetContentByWidgetDataStrategy();

  @override
  Future<ComponentResponse> execute(WidgetModel model, ComponentRequest request) async {
    return SuccessResponse(data: model.data);
  }

  @override
  bool isApplicable(WidgetModel model) {
    return model.state == WidgetState.success;
  }
}
