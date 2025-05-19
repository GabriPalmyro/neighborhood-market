import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/data/model/product_gallery_model.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';
import 'package:neighborhood_market/app/features/product_payment/data/model/shipping_informations_model.dart';
import 'package:neighborhood_market/app/features/product_payment/data/model/shipping_method_model.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/boundary/product_payment_order_repository.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_informations_entity.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_method_entity.dart';

@Injectable(as: ProductPaymentOrderRepository)
class ProductPaymentOrderRepositoryImpl implements ProductPaymentOrderRepository {
  ProductPaymentOrderRepositoryImpl(this.provider);
  final NetworkProvider provider;

  @override
  Future<ProductGalleryItemEntity> getProductPaymentOrder(String id) async {
    final network = await provider.getNetworkInstance();

    final response = await network.get('/item/$id');

    return ProductGalleryItemModel.fromJson(
      response.data['item'],
    ).toEntity();
  }

  @override
  Future<ShippingInformationsEntity> getShippingInformations() async {
    final network = await provider.getNetworkInstance();

    final response = await network.get('/user');

    return ShippingInformationsModel.fromJson(
      response.data,
    ).toEntity();
  }

  @override
  Future<List<ShippingMethodEntity>> getShippingMethods() async {
    final network = await provider.getNetworkInstance();

    final response = await network.get('/shipping');

    return (response.data as List<dynamic>)
        .map((e) => ShippingMethodModel.fromJson(e).toEntity())
        .toList();
  }
}
