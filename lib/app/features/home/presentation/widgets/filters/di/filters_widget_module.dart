import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/di/component_default_feature_module.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/domain/boundary/filters_mapper.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/domain/model/filters_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/presentation/builder/filters_widget_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/presentation/filters_widget.dart';

class FiltersWidgetModule extends ComponentDefaultFeatureModule<FiltersModel, FiltersWidget> {
  @override
  FutureOr<void> init(GetItHelper gh) {
    gh.factory<ComponentContentMapper<FiltersModel>>(() => FiltersModelMapper());
    gh.factory<ComponentBuilder<FiltersWidget>>(
      () => FiltersWidgetBuilder(gh<GetContentCommand<FiltersModel>>()),
    );
    return super.init(gh);
  }
}
