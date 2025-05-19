import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/di/component_default_feature_module.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/domain/boundary/search_mapper.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/domain/model/search_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/presentation/builder/search_widget_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/presentation/search_widget.dart';

class SearchWidgetModule extends ComponentDefaultFeatureModule<SearchModel, SearchWidget> {
  @override
  FutureOr<void> init(GetItHelper gh) {
    gh.factory<ComponentContentMapper<SearchModel>>(() => SearchModelMapper());
    gh.factory<ComponentBuilder<SearchWidget>>(
      () => SearchWidgetBuilder(gh<GetContentCommand<SearchModel>>()),
    );
    return super.init(gh);
  }
}
