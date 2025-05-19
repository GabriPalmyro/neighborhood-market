import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/domain/model/search_model.dart';

class SearchModelMapper extends ComponentContentMapper<SearchModel> {
  @override
  SearchModel mapToContent(dynamic json) {
    return SearchModel.fromJson(json);
  }
}