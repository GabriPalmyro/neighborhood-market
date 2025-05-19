import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/di/component_default_feature_module.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/domain/boundary/text_mapper.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/domain/model/text_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/presentation/builder/text_widget_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/presentation/text_widget.dart';

class TextWidgetModule extends ComponentDefaultFeatureModule<TextModel, TextWidget> {
  @override
  FutureOr<void> init(GetItHelper gh) {
    gh.factory<ComponentContentMapper<TextModel>>(() => TextModelMapper());
    gh.factory<ComponentBuilder<TextWidget>>(
      () => TextWidgetBuilder(gh<GetContentCommand<TextModel>>()),
    );
    return super.init(gh);
  }
}
