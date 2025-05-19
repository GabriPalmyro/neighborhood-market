import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_event.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/dynamic_widget_builder.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/helpers/widget_edge_insets.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/domain/model/shop_galerry_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/presentation/widgets/shop_gallery_success_widget.dart';

class ShopGalleryWidget extends StatelessWidget {
  const ShopGalleryWidget({
    required this.model,
    required this.provider,
    required this.navigator,
    super.key,
  });

  final WidgetModel model;
  final GetContentCommand<ShopGalleryModel> provider;
  final AppNavigator navigator;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    final insets = WidgetEdgeInsets.fromWidgetBounds(
      spacing: tokens.spacing,
      bounds: model.style?.bounds,
    ).insets;

    return Padding(
      padding: insets,
      child: DynamicWidgetBuilder<ShopGalleryModel, GetContentCommand<ShopGalleryModel>>(
        provider: provider,
        modelWidgetBuilder: (provider) => provider.execute(
          GetContentEvent(content: model),
        ),
        successBuilder: (_, model) => ShopGallerySuccessWidget(
          model: model,
          navigator: navigator,
        ),
      ),
    );
  }
}
