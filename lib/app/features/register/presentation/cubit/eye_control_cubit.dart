import 'package:flutter_bloc/flutter_bloc.dart';

class EyeControlCubit extends Cubit<bool> {
  EyeControlCubit() : super(false);

  void changeEyeState() {
    emit(!state);
  }
}