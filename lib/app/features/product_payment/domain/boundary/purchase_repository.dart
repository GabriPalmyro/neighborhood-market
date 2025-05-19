import 'package:neighborhood_market/app/features/product_payment/domain/entities/payment_data_entity.dart';

abstract class PurchaseRepository {
  Future<PaymentDataEntity> generatePayment({
    required String productId,
    required String type,
    required String fullName,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String zip,
    required String deliveryType,
    String? offerId,
  });
  
  void updateListProducts();
}
