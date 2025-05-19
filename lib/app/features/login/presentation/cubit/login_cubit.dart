import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/login/domain/login_interactor.dart';
import 'package:neighborhood_market/app/features/login/presentation/cubit/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.interactor) : super(const LoginInitial());
  final LoginInteractor interactor;

  Future<void> login(String email, String password) async {
    try {
      emit(const LoginLoading());
      await interactor.login(email: email, password: password);
      emit(const LoginSuccess());
    } on Exception catch (e) {
      emit(LoginFailure(e));
    } catch (_) {
      emit(LoginFailure(Exception('An unknown error occurred')));
    }
  }
}
