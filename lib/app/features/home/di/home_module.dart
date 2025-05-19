import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter_builder.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/home_cubit.dart';
import 'package:neighborhood_market/app/features/home/presentation/page/home_page_factory.dart';

@module
abstract class HomeModule {
  @Named('HomePageFactory')
  ComponentsPageFactory provideHomePageFactory(
    HomeCubit cubit,
    ComponentContentAdapterBuilder adapterBuilder,
  ) {
    return HomePageFactory()
      ..addHomeCubit(cubit)
      ..addAdapter(adapterBuilder.build());
  }
}
