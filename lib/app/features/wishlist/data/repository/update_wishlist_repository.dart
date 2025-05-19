import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';

abstract class UpdateWishlistRepository {
  Stream<UpdateWishlistEvent> wishlistUpdateStream();
  void updateWishlist();
}

@LazySingleton(as: UpdateWishlistRepository)
class UpdateWishlistRepositoryImpl implements UpdateWishlistRepository {
  UpdateWishlistRepositoryImpl(this.reactiveListener);

  final ReactiveListener reactiveListener;

  @override
  Stream<UpdateWishlistEvent> wishlistUpdateStream() => reactiveListener.subscribe<UpdateWishlistEvent>();

  @override
  void updateWishlist() {
    reactiveListener.publish(const UpdateWishlistEvent());
  }
}

class UpdateWishlistEvent {
  const UpdateWishlistEvent();
}
