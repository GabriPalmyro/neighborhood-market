import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/payment_service/stripe_service.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/boundary/purchase_repository.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/payment_data_entity.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/purchase_type_enum.dart';
import 'package:neighborhood_market/app/features/product_payment/domain/entities/shipping_method_entity.dart';
import 'package:neighborhood_market/app/utils/errors/payment_exceptions.dart';

part 'purchase_state.dart';

@injectable
class PurchaseCubit extends Cubit<PurchaseState> {
  PurchaseCubit(
    this.repository,
    this.paymentService,
  ) : super(const PurchaseInitial());

  final PurchaseRepository repository;
  final StripeService paymentService;

  Future<void> getPaymentIntent({
    required String productId,
    required PurchaseType type,
    required String fullName,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String zip,
    required String deliveryType,
    String? offerId,
  }) async {
    emit(const PurchaseLoading());
    try {
      final paymentIntent = await repository.generatePayment(
        productId: productId,
        type: type.toValue(),
        offerId: offerId,
        fullName: fullName,
        address1: address1,
        address2: address2,
        city: city,
        state: state,
        zip: zip,
        deliveryType: deliveryType,
      );
      emit(PaymentIntentSuccess(paymentIntent));
    } catch (e) {
      if (e is DioException) {
        final String? errorMessage = e.response?.data['message'] as String?;
        emit(
          errorMessage != null ? PurchaseError(PaymentGeneralException(errorMessage)) : const PurchaseError(PaymentIntentException()),
        );
      } else {
        emit(const PurchaseError(PaymentIntentException()));
      }
    }
  }

  Future<void> confirmPayment({
    required String clientSecret,
    required ProductGalleryItemEntity product,
    ShippingMethodEntity? delivery,
  }) async {
    emit(const PurchaseLoading());
    try {
      final payment = await paymentService.makePayment(clientSecret);
      emit(
        PaymentConfirmed(
          DateTime.now(),
          payment?.label ?? 'Credit Card',
          delivery,
          product,
        ),
      );
    } on PaymentExceptions catch (e) {
      emit(PurchaseError(e));
    }
  }

  void updateProductList() {
    repository.updateListProducts();
  }
}
