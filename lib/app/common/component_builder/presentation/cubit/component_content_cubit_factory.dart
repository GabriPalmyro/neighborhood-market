import 'package:flutter/widgets.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/component_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/cubit/component_content_cubit.dart';

abstract class ComponentContentCubitFactory<T extends Widget> {
  const ComponentContentCubitFactory();

  void addCommand(ComponentContentCommand command);

  ComponentContentCubit<T> create();
}

class ComponentContentCubitFactoryDefault<T extends Widget> extends ComponentContentCubitFactory {
  ComponentContentCubitFactoryDefault();

  late ComponentContentCommand _command;

  @override
  void addCommand(ComponentContentCommand command) {
    _command = command;
  }

  @override
  ComponentContentCubit<T> create() {
    return ComponentContentCubit<T>(_command);
  }
}
