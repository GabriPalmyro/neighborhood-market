import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/domain/model/filters_model.dart';

class FiltersModelMapper extends ComponentContentMapper<FiltersModel> {
  @override
  FiltersModel mapToContent(dynamic json) {
    return FiltersModel.fromJson(json);
  }
}