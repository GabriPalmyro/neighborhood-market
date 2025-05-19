import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/domain/model/text_model.dart';

class TextModelMapper extends ComponentContentMapper<TextModel> {
  @override
  TextModel mapToContent(dynamic json) {
    return TextModel.fromJson(json);
  }
}