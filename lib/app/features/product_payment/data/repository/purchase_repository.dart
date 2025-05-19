import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart';
import 'package:neighborhood_market/app/features/product_payment/data/model/payment_data_model.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/boundary/purchase_repository.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/payment_data_entity.dart';

@Injectable(as: PurchaseRepository)
class PurchaseRepositoryImpl implements PurchaseRepository {
  PurchaseRepositoryImpl({
    required this.provider,
    required this.reactiveListener,
  });

  final NetworkProvider provider;
  final ReactiveListener reactiveListener;

  @override
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
  }) async {
    final network = await provider.getNetworkInstance();

    final data = {
      'itemId': productId,
      'type': type,
      'fullName': fullName,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
      'zip': zip,
      'deliveryType': deliveryType,
    };

    if (offerId != null) {
      data['offerId'] = offerId;
    }

    final response = await network.post(
      '/stripe',
      data: data,
    );

    return PaymentDataModel.fromJson(response.data).toEntity;
  }

  @override
  void updateListProducts() {
    reactiveListener.publish(const FiltersSelected());
  }
}
