import 'package:neighborhood_market/app/features/purchasing_setup/domain/entities/payment_method_entity.dart';

abstract class PurchasingSetupRepository {
  Future<List<PaymentMethodEntity>> getPaymentsReceiveMethods();
  Future<void> changePaymentReceiveMethodState(String id, bool state);
}
