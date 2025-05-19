import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/data/model/payment_method_model.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/domain/boundary/purchasing_setup_repository.dart';
import 'package:neighborhood_market/app/features/purchasing_setup/domain/entities/payment_method_entity.dart';

@Injectable(as: PurchasingSetupRepository)
class PurchasingSetupRepositoryImpl implements PurchasingSetupRepository {
  PurchasingSetupRepositoryImpl({required this.provider});

  final NetworkProvider provider;

  @override
  Future<List<PaymentMethodEntity>> getPaymentsReceiveMethods() async {
    final network = await provider.getNetworkInstance();

    final response = await network.get('/payment-methods');

    return (response.data as List).map((e) => PaymentMethodModel.fromJson(e).toEntity).toList();
  }

  @override
  Future<void> changePaymentReceiveMethodState(String id, bool state) async {
    final network = await provider.getNetworkInstance();

    await network.put('/payment-methods/$id', data: {'active': state});
  }
}
