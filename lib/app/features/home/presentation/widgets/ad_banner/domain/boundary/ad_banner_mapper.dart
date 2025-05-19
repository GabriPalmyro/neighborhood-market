import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/ad_banner/domain/model/ad_banner_model.dart';

class AdBannerModelMapper extends ComponentContentMapper<AdBannerModel> {
  @override
  AdBannerModel mapToContent(dynamic json) {
    return AdBannerModel.fromJson(json);
  }
}