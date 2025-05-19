import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/domain/model/shop_galerry_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/presentation/shop_galerry_widget.dart';

class ShopGalerryWidgetBuilder implements ComponentBuilder<ShopGalleryWidget> {
  ShopGalerryWidgetBuilder(this.provider);
  final GetContentCommand<ShopGalleryModel> provider;
  late AppNavigator navigator;

  void addNavigator(AppNavigator navigator) {
    this.navigator = navigator;
  }

  @override
  Widget create(WidgetModel model) {
    return ShopGalleryWidget(
      model: model,
      provider: provider,
      navigator: navigator,
    );
  }
}
