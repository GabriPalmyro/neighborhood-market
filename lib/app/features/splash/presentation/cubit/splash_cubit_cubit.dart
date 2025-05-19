import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';

part 'splash_cubit_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._authService) : super(const SplashInitial());

  final AuthService _authService;

  Future<void> checkUserAuthenticated() async {
    try {
      final accessToken = await _authService.getAccessToken();
      final user = await _authService.getUserId();
      // final isActive = await _authService.getIsActive();

      await Future.delayed(const Duration(seconds: 2));

      if (user != null && accessToken != null) {
        // if (!(isActive ?? true)) {
        //   emit(const SplashDeactivated());
        //   return;
        // }

        emit(const SplashAuthenticated());
      } else {
        emit(const SplashUnauthenticated());
      }
    } catch (_) {
      emit(const SplashUnauthenticated());
    }
  }
}
