import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/widget_model.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/domain/model/search_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/presentation/search_widget.dart';

class SearchWidgetBuilder implements ComponentBuilder<SearchWidget> {
  const SearchWidgetBuilder(this.provider);
  final GetContentCommand<SearchModel> provider;

  @override
  Widget create(WidgetModel model) {
    return SearchWidget(
      model: model,
      provider: provider,
    );
  }
}
