import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/domain/boundary/purchasing_setup_repository.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/domain/entities/payment_method_entity.dart';

part 'purchasing_setup_state.dart';

@injectable
class PurchasingSetupCubit extends Cubit<PurchasingSetupState> {
  PurchasingSetupCubit(this.repository) : super(const PurchasingSetupInitial());

  final PurchasingSetupRepository repository;

  Future<void> getPurchasingSetup() async {
    emit(const PurchasingSetupLoading());
    try {
      final methods = await repository.getPaymentsReceiveMethods();
      emit(PurchasingSetupLoaded(methods));
    } catch (e) {
      emit(const PurchasingSetupError());
    }
  }

  Future<void> changePaymentMethodStatus(String id) async {
    final currentState = state;
    if (currentState is PurchasingSetupLoaded) {
      final methods = currentState.paymentMethods.map((e) {
        if (e.id == id) {
          return e.copyWith(isEnabled: !e.isEnabled);
        }
        return e;
      }).toList();

      emit(PurchasingSetupLoaded(methods));
      await repository.changePaymentReceiveMethodState(
        id,
        !currentState.paymentMethods.firstWhere((element) => element.id == id).isEnabled,
      );
    }
  }
}
