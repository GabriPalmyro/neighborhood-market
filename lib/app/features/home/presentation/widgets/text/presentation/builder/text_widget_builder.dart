import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/domain/model/text_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/presentation/text_widget.dart';

class TextWidgetBuilder implements ComponentBuilder<TextWidget> {
  const TextWidgetBuilder(this.provider);
  final GetContentCommand<TextModel> provider;

  @override
  Widget create(WidgetModel model) {
    return TextWidget(
      model: model,
      provider: provider,
    );
  }
}
