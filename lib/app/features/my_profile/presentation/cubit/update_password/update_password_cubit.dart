import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/my_profile/domain/boundary/my_profile_repository.dart';

part 'update_password_state.dart';

@injectable
class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit(this.repository) : super(const UpdatePasswordInitial());

  final MyProfileRepository repository;

  void updatePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    try {
      emit(const UpdatePasswordLoading());
      repository.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(const UpdatePasswordSuccess());
    } catch (e) {
      emit(UpdatePasswordFailure(e.toString()));
    }
  }
}
