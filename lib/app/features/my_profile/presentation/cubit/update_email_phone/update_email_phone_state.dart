part of 'update_email_phone_cubit.dart';

enum UpdateEmailPhoneStatus { initial, loading, codeSent, codeVerified, error }

enum UpdateEmailPhoneType { email, phone }

sealed class UpdateEmailPhoneState extends Equatable {
  const UpdateEmailPhoneState();

  @override
  List<Object?> get props => [];
}

final class UpdateEmailPhoneInitial extends UpdateEmailPhoneState {
  const UpdateEmailPhoneInitial({
    this.status = UpdateEmailPhoneStatus.initial,
    this.type,
  });

  final UpdateEmailPhoneStatus status;
  final UpdateEmailPhoneType? type;

  UpdateEmailPhoneInitial copyWith({
    UpdateEmailPhoneStatus? status,
    UpdateEmailPhoneType? type,
  }) {
    return UpdateEmailPhoneInitial(
      status: status ?? this.status,
      type:type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        status,
        type,
      ];
}
