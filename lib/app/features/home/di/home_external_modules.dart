import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/di/filters_widget_module.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/di/search_widget_module.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/di/shop_gallery_widget_module.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/di/text_widget_module.dart';

const List<ExternalModule> homeExternalModules = [
  ExternalModule(TextWidgetModule),
  ExternalModule(SearchWidgetModule),
  ExternalModule(FiltersWidgetModule),
  ExternalModule(ShopGalleryWidgetModule),
];
