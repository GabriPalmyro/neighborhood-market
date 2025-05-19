import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/model/header_model.dart';

class HeaderModelMapper extends ComponentContentMapper<HeaderModel> {
  @override
  HeaderModel mapToContent(dynamic json) {
    return HeaderModel.fromJson(json);
  }
}