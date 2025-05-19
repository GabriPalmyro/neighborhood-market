import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter_builder.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:neighborhood_market/app/features/explore/presentation/page/explore_page_factory.dart';

@module
abstract class ExploreModule {
  @Named('ExplorePageFactory')
  ComponentsPageFactory provideExplorePageFactory(
    ExploreCubit cubit,
    ComponentContentAdapterBuilder adapterBuilder,
  ) {
    return ExplorePageFactory()
      ..addExploreCubit(cubit)
      ..addAdapter(adapterBuilder.build());
  }
}
