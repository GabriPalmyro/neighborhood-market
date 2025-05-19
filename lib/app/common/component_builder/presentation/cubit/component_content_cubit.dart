import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_content_result.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/entities/component_event.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/use_case/component_content_command.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/cubit/component_content_state.dart';

class ComponentContentCubit<T extends Widget> extends Cubit<ComponentContentState> {
  ComponentContentCubit(
    this._command,
  ) : super(const ComponentContentInitial());

  final ComponentContentCommand _command;

  Future<void> invoike(ComponentEvent event) async {
    try {
      emit(const ComponentContentLoading());
      final result = await _command.execute(event);

      if(result is ContentSuccess) {
        emit(ComponentContentLoaded(content: result.data));
      } else if(result is ContentError) {
        emit(const ComponentContentError());
      }

    } catch (e) {
      emit(const ComponentContentError());
    }
  }
}
