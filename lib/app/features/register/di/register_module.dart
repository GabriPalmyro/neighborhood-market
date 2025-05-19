import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/eye_control_cubit.dart';

@module
abstract class RegisterModule {
  EyeControlCubit provideEyeControlCubit() => EyeControlCubit();
}
