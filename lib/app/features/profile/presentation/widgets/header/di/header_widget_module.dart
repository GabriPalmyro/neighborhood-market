import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/di/component_default_feature_module.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/boundary/header_mapper.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/model/header_model.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/presentation/builder/header_widget_builder.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/presentation/header_widget.dart';

class HeaderWidgetModule extends ComponentDefaultFeatureModule<HeaderModel, HeaderWidget> {
  @override
  FutureOr<void> init(GetItHelper gh) {
    gh.factory<ComponentContentMapper<HeaderModel>>(() => HeaderModelMapper());
    gh.factory<ComponentBuilder<HeaderWidget>>(
      () => HeaderWidgetBuilder(gh<GetContentCommand<HeaderModel>>()),
    );
    return super.init(gh);
  }
}
