import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/recover_password/domain/boundary/recover_password_repository.dart';

import 'recover_password_state.dart';

@injectable
class RecoverPasswordCubit extends Cubit<RecoverPasswordState> {
  RecoverPasswordCubit(this.repository) : super(const RecoverPasswordInitial());

  final RecoverPasswordRepository repository;

  void initToCode(String email) {
    emit(RecoverPasswordCodeSent(email));
  }

  void initToNewPassword(String email, String jwt) {
    emit(RecoverPasswordCodeValidated(email, jwt));
  }

  /// Simulate sending the recovery code to the email
  Future<void> sendRecoveryCode(String email) async {
    emit(const RecoverPasswordLoading());
    try {
      await repository.sendCodeToEmail(email);
      emit(RecoverPasswordCodeSent(email));
    } catch (e) {
      emit(
        const RecoverPasswordError(
          message: 'Failed to send code. Please try again.',
        ),
      );
    }
  }

  Future<void> validateRecoveryCode(String code) async {
    // if (state is! RecoverPasswordCodeSent) {
    //   return;
    // }

    String? email;

    if (state is RecoverPasswordCodeSent) {
      email = (state as RecoverPasswordCodeSent).email;
    } else if (state is RecoverPasswordError) {
      email = (state as RecoverPasswordError).email;
    }

    if (email == null) {
      emit(
        const RecoverPasswordError(
          message: 'Failed to validate code. Please try again.',
        ),
      );
      return;
    }

    try {
      emit(RecoverPasswordLoading(email: email));
      final jwt = await repository.validateRecoveryCode(code);
      emit(RecoverPasswordCodeValidated(email, jwt));
    } catch (e) {
      emit(
        RecoverPasswordError(
          message: 'Failed to validate code. Please try again.',
          email: email,
        ),
      );
    }
  }

  Future<void> resetPassword(String newPassword) async {
    String? email;
    String? jwt;

    if (state is RecoverPasswordCodeValidated) {
      email = (state as RecoverPasswordCodeValidated).email;
      jwt = (state as RecoverPasswordCodeValidated).jwt;
    } else if (state is RecoverPasswordError) {
      email = (state as RecoverPasswordError).email;
    }

    if (email == null || jwt == null) {
      emit(
        const RecoverPasswordError(
          message: 'Failed to reset password. Please try again.',
        ),
      );
      return;
    }

    try {
      emit(RecoverPasswordLoading(email: email));
      await repository.resetPassword(email, newPassword, jwt);
      // Password reset successful
      emit(RecoverPasswordSuccess(email));
    } catch (e) {
      emit(
        RecoverPasswordError(
          message: 'Failed to reset password. Please try again.',
          email: email,
          jwt: jwt,
        ),
      );
    }
  }
}
