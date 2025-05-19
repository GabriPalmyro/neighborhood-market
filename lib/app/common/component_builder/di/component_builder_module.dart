import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter_builder.dart';

@module
abstract class ComponentBuilderModule {
  ComponentContentAdapterBuilder providesComponentContentAdapterBuilder() => ComponentContentAdapterBuilderImpl();
}
