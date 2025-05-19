import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/di/component_default_feature_module.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/domain/model/shop_galerry_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/presentation/builder/shop_gallery_widget_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/presentation/shop_galerry_widget.dart';

class ShopGalleryWidgetModule extends ComponentDefaultFeatureModule<ShopGalleryModel, ShopGalleryWidget> {
  @override
  FutureOr<void> init(GetItHelper gh) {
    gh.factory<ComponentBuilder<ShopGalleryWidget>>(
      () => ShopGalerryWidgetBuilder(gh<GetContentCommand<ShopGalleryModel>>())
        ..addNavigator(
          gh<AppNavigator>(),
        ),
    );
    return super.init(gh);
  }
}
