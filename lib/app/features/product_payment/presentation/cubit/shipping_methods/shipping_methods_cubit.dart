import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/boundary/product_payment_order_repository.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_method_entity.dart';

part 'shipping_methods_state.dart';

@injectable
class ShippingMethodsCubit extends Cubit<ShippingMethodsState> {
  ShippingMethodsCubit(this.repository) : super(const ShippingMethodsInitial());

  final ProductPaymentOrderRepository repository;

  Future<void> getShippingMethods() async {
    try {
      emit(const ShippingMethodsLoading());
      final shippingMethods = await repository.getShippingMethods();
      emit(ShippingMethodsLoaded(shippingMethods));
    } catch (e) {
      emit(ShippingMethodsFailure(e.toString()));
    }
  }
}
