import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_event.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/dynamic_widget_builder.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/helpers/widget_edge_insets.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/text/domain/model/text_model.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    required this.model,
    required this.provider,
    super.key,
  });

  final WidgetModel model;
  final GetContentCommand<TextModel> provider;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    final insets = WidgetEdgeInsets.fromWidgetBounds(
      spacing: tokens.spacing,
      bounds: model.style?.bounds,
    ).insets;

    return Padding(
      padding: insets,
      child: DynamicWidgetBuilder<TextModel, GetContentCommand<TextModel>>(
        provider: provider,
        modelWidgetBuilder: (provider) => provider.execute(
          GetContentEvent(content: model),
        ),
        successBuilder: (_, model) => DSText(model.title ?? ''),
      ),
    );
  }
}
