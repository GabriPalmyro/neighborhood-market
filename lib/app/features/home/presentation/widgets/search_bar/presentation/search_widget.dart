import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_event.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/dynamic_widget_builder.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/helpers/widget_edge_insets.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/domain/model/search_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/presentation/widget/search_success_widget.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    required this.model,
    required this.provider,
    super.key,
  });

  final WidgetModel model;
  final GetContentCommand<SearchModel> provider;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    final insets = WidgetEdgeInsets.fromWidgetBounds(
      spacing: tokens.spacing,
      bounds: model.style?.bounds,
    ).insets;

    return Padding(
      padding: insets,
      child: DynamicWidgetBuilder<SearchModel, GetContentCommand<SearchModel>>(
        provider: provider,
        modelWidgetBuilder: (provider) => provider.execute(GetContentEvent(content: model)),
        successBuilder: (_, model) => SearchSuccessWidget(
          label: model.label,
          leadingIcon: DSIcons.fromString(model.leadingIcon),
        ),
      ),
    );
  }
}
