import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter_builder.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/builder/component_builder.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:neighborhood_market/app/features/profile/presentation/page/profile_page_factory.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/header/presentation/header_widget.dart';

@module
abstract class ProfileModule {
  @Named('ProfilePageFactory')
  ComponentsPageFactory provideProfilePageFactory(
    ProfileCubit cubit,
    ComponentContentAdapterBuilder adapterBuilder,
  ) {
    _registerWidgetsBuilders(adapterBuilder);
    return ProfilePageFactory()
      ..addAdapter(adapterBuilder.build())
      ..setProfileCubit(cubit)
      ..setAppNavigator(GetIt.I.get<AppNavigator>());
  }

  void _registerWidgetsBuilders(ComponentContentAdapterBuilder adapterBuilder) {
    adapterBuilder
      .addBuilder('header', (model) {
        final builder = GetIt.I.get<ComponentBuilder<HeaderWidget>>();
        return builder.create(model);
      });
  }
}
