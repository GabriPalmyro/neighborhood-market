import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';
import 'package:neighborhood_market/app/features/register/domain/repositories/register_repository.dart';
import 'package:neighborhood_market/app/features/register/presentation/cubit/register/register_state.dart';
import 'package:neighborhood_market/app/features/register/utils/register_string.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this.repository,
    this.authService,
  ) : super(
          const RegisterInitial(),
        );

  final RegisterRepository repository;
  final AuthService authService;

  Future<void> createAccountStep({
    required String email,
    required String password,
    required String phoneNumber,
    required String country,
  }) async {
    emit(const RegisterLoading());
    try {
      final timezone = await repository.getTimezone();
      await repository.registerUser(
        email: email,
        password: password,
        phoneNumber: country + phoneNumber,
        timezone: timezone,
      );
      emit(const RegisterSuccess());
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 406) {
          emit(
            const ZipCodeNotProvidedFailure(),
          );
        } else if (e.response?.statusCode == 429) {
          emit(
            const RegisterFailure('You have reached the maximum number of attempts'),
          );
        } else {
          emit(
            const RegisterFailure(RegisterStrings.createAccountErrorLabel),
          );
        }
        emit(RegisterFailure(e.response?.data['message']));
      } else {
        emit(
          const RegisterFailure(RegisterStrings.createAccountErrorLabel),
        );
      }
    }
  }

  Future<void> verifyPhoneNumberStep({
    required String code,
  }) async {
    emit(const RegisterLoading());
    try {
      final userId = await repository.verifyOTPCode(otpCode: code);
      await authService.setUserId(userId);
      emit(const RegisterSuccess());
    } catch (e) {
      if (e is DioException) {
        emit(
          RegisterFailure(
            e.response?.data['message'] ?? RegisterStrings.createAccountErrorLabel,
          ),
        );
      } else {
        emit(
          const RegisterFailure(RegisterStrings.createAccountErrorLabel),
        );
      }
    }
  }

  Future<void> savePersonalInformationStep({
    required String username,
    required String fullName,
    required String birthDate,
    required String adress1,
    required String adress2,
    required String city,
    required String state,
    required String zip,
  }) async {
    emit(const RegisterLoading());
    try {
      final userId = await authService.getUserId();
      await repository.completeProfile(
        userId: userId ?? '',
        username: username,
        fullName: fullName,
        birthDate: birthDate,
        address1: adress1,
        address2: adress2,
        city: city,
        state: state,
        zip: zip,
      );
      emit(const RegisterSuccess());
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 429) {
          emit(
            const RegisterFailure('You have reached the maximum number of attempts'),
          );
        } else {
          emit(
            const RegisterFailure(RegisterStrings.createAccountErrorLabel),
          );
        }
        emit(RegisterFailure(e.response?.data['message']));
      } else {
        emit(
          const RegisterFailure(RegisterStrings.createAccountErrorLabel),
        );
      }
    }
  }
}
