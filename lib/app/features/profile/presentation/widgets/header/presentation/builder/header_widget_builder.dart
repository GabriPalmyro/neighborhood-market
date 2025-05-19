import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/domain/model/header_model.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/presentation/header_widget.dart';

class HeaderWidgetBuilder implements ComponentBuilder<HeaderWidget> {
  const HeaderWidgetBuilder(this.provider);
  final GetContentCommand<HeaderModel> provider;

  @override
  Widget create(WidgetModel model) {
    return HeaderWidget(
      model: model,
      provider: provider,
    );
  }
}
