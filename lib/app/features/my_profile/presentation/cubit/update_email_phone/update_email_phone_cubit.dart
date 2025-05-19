import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/boundary/update_phone_email_repository.dart';

part 'update_email_phone_state.dart';

@injectable
class UpdateEmailPhoneCubit extends Cubit<UpdateEmailPhoneState> {
  UpdateEmailPhoneCubit(this.repository) : super(const UpdateEmailPhoneInitial());

  final UpdatePhoneEmailRepository repository;

  Future<void> sendCodeToNewPhone(String phone) async {
    try {
      emit(
        (state as UpdateEmailPhoneInitial).copyWith(
          status: UpdateEmailPhoneStatus.loading,
          type: UpdateEmailPhoneType.phone,
        ),
      );

      await repository.sendCodeToNewPhone(phone);

      emit(
        (state as UpdateEmailPhoneInitial).copyWith(
          status: UpdateEmailPhoneStatus.codeSent,
        ),
      );
    } catch (e) {
      emit(
        (state as UpdateEmailPhoneInitial).copyWith(
          status: UpdateEmailPhoneStatus.error,
        ),
      );
    }
  }

  Future<void> sendCodeToNewEmail(String email) async {
    try {
      emit(
        (state as UpdateEmailPhoneInitial).copyWith(
          status: UpdateEmailPhoneStatus.loading,
          type: UpdateEmailPhoneType.email,
        ),
      );

      await repository.sendCodeToNewEmail(email);

      emit(
        (state as UpdateEmailPhoneInitial).copyWith(
          status: UpdateEmailPhoneStatus.codeSent,
        ),
      );
    } catch (e) {
      emit(
        (state as UpdateEmailPhoneInitial).copyWith(
          status: UpdateEmailPhoneStatus.error,
        ),
      );
    }
  }

  Future<void> verifyCode(String code) async {
    try {
      emit(
        (state as UpdateEmailPhoneInitial).copyWith(
          status: UpdateEmailPhoneStatus.loading,
        ),
      );

      await repository.verifyCode(code);

      emit(
        (state as UpdateEmailPhoneInitial).copyWith(
          status: UpdateEmailPhoneStatus.codeVerified,
        ),
      );
    } catch (e) {
      emit(
        (state as UpdateEmailPhoneInitial).copyWith(
          status: UpdateEmailPhoneStatus.error,
        ),
      );
    }
  }
}
