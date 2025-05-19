import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/domain/model/filters_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/presentation/filters_widget.dart';

class FiltersWidgetBuilder implements ComponentBuilder<FiltersWidget> {
  const FiltersWidgetBuilder(this.provider);
  final GetContentCommand<FiltersModel> provider;

  @override
  Widget create(WidgetModel model) {
    return FiltersWidget(
      model: model,
      provider: provider,
    );
  }
}
