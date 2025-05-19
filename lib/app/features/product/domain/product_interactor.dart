import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/dynamic_link/dynamic_link_service.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/following/domain/event/update_following_list_event.dart';
import 'package:neighborhood_market/app/features/product/domain/boundaries/product_repository.dart';
import 'package:neighborhood_market/app/features/product/domain/entities/product_entity.dart';
import 'package:neighborhood_market/app/features/product/domain/event/update_product_event.dart';

abstract class ProductInteractor {
  Future<ProductEntity> getProductDetails(String id);
  Future<void> changeLikeStatus(bool status, String id);
  Future<String> createProductDynamicLink(String productId);
  Future<bool> showShareProductLink();
  Future<void> changeFollowStatus(bool status, String id);
  void emitFollowingUpdateEvent();
  Stream<UpdateProductEvent> updateProductStream();
}

@Injectable(as: ProductInteractor)
class ProductInteractorImpl implements ProductInteractor {
  ProductInteractorImpl(this._repository, this._dynamicLinkService, this._reactiveListener);
  final DynamicLinkService _dynamicLinkService;
  final ProductRepository _repository;
  final ReactiveListener _reactiveListener;

  @override
  Future<ProductEntity> getProductDetails(String id) async {
    return _repository.getProductDetails(id);
  }

  @override
  Future<void> changeLikeStatus(bool status, String id) async {
    if (status) {
      await _repository.likeProduct(id);
    } else {
      await _repository.unlikeProduct(id);
    }
  }

  @override
  Future<String> createProductDynamicLink(String productId) {
    return _dynamicLinkService.createProductDynamicLink(productId);
  }

  @override
  Future<bool> showShareProductLink() => _repository.getShowShareButton();

  @override
  Future<void> changeFollowStatus(bool status, String id) {
    if (status) {
      return _repository.followSeller(id);
    } else {
      return _repository.unfollowSeller(id);
    }
  }

  @override
  void emitFollowingUpdateEvent() {
    _reactiveListener.publish(const UpdateFollowingListEvent());
  }

  @override
  Stream<UpdateProductEvent> updateProductStream() => _reactiveListener.subscribe<UpdateProductEvent>();
}
