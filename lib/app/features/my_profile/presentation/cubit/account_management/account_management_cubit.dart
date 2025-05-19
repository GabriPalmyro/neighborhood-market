import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/boundary/my_profile_repository.dart';
import 'package:neighborhood_market/app/features/profile/domain/profile_interactor.dart';

part 'account_management_state.dart';

@injectable
class AccountManagementCubit extends Cubit<AccountManagementState> {
  AccountManagementCubit(this.repository, this.profileInteractor) : super(const AccountManagementInitial());

  final MyProfileRepository repository;
  final ProfileInteractor profileInteractor;

  Future<void> deactivateAccount() async {
    try {
      emit(const AccountManagementLoading());
      await repository.deactivateAccount();
      emit(const AccountDeactivateSuccess());
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      emit(AccountManagementError(message));
    } catch (e) {
      emit(const AccountManagementError('Account could not be deactivated'));
    }
  }

  Future<void> deleteAccount() async {
    try {
      emit(const AccountManagementLoading());
      await repository.deleteAccount();
      emit(const AccountDeleteSuccess());
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      emit(AccountManagementError(message));
    } catch (e) {
      emit(const AccountManagementError('Account could not be deleted'));
    }
  }

  Future<void> reactivateAccount() async {
    try {
      emit(const AccountManagementLoading());
      await repository.reactivateAccount();
      emit(const AccountActivatedSuccess());
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      emit(AccountManagementError(message));
    } catch (e) {
      emit(const AccountManagementError('Account could not be reactivated'));
    }
  }

  Future<void> logout() async {
    await profileInteractor.logout();
  }
}
