import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/data/component_repository_factory_default.dart';
import 'package:neighborhood_market/app/common/component_builder/data/data_source/remote_component_data_source.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component__content_request_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/mapper/component_content_mapper.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/component_content_command_factory.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/get_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/cubit/component_content_cubit.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/cubit/component_content_cubit_factory.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/by_widget/get_content_by_widget_data_strategy.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/by_widget/get_content_by_widget_error_strategy.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/by_widget/get_content_by_widget_path_strategy.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/strategy/component_content_by_widget_strategy_factory.dart';
import 'package:neighborhood_market/app/common/network/network.dart';

abstract class ComponentDefaultFeatureModule<E, W extends Widget> extends MicroPackageModule {
  @override
  FutureOr<void> init(GetItHelper gh) {
    gh.factory<ComponentContentCubit<W>>(() {
      const ComponentContentRequestMapper loadContentMapper = LoadContentRequestMapper();

      final repositoryFactory = ComponentRepositoryFactoryDefault()
        ..addRemoteDataSource(
          RemoteComponentDataSource(
            gh<NetworkProvider>(),
          ),
        );

      final componentContentByWidgetStrategyFactory = DefaultComponentContentByWidgetStrategyFactory()
        ..addStrategy(GetContentByErrorDataStrategy())
        ..addStrategy(GetContentByWidgetDataStrategy())
        ..addStrategy(GetContentByWidgetPathStrategy(repositoryFactory.create()));

      final contentCommandFactory = ComponentContentCommandFactoryDefault()
        ..addMapper(gh<ComponentContentMapper<E>>())
        ..addRequestMapper(loadContentMapper)
        ..addStrategy(componentContentByWidgetStrategyFactory.create());

      final contentCubitFactory = ComponentContentCubitFactoryDefault<W>()..addCommand(contentCommandFactory.create());

      return contentCubitFactory.create();
    });

    gh.factory<GetContentCommand<E>>(() {
      const ComponentContentRequestMapper loadContentMapper = LoadContentRequestMapper();

      final repositoryFactory = ComponentRepositoryFactoryDefault()
        ..addRemoteDataSource(
          RemoteComponentDataSource(
            gh<NetworkProvider>(),
          ),
        );

      final componentContentByWidgetStrategyFactory = DefaultComponentContentByWidgetStrategyFactory()
        ..addStrategy(GetContentByErrorDataStrategy())
        ..addStrategy(GetContentByWidgetDataStrategy())
        ..addStrategy(GetContentByWidgetPathStrategy(repositoryFactory.create()));

        return GetContentCommandImpl(
          gh<ComponentContentMapper<E>>(),
          loadContentMapper,
          componentContentByWidgetStrategyFactory.create(),
        );
    });
  }
}
