import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/product/domain/boundaries/product_repository.dart';
import 'package:neighborhood_market/app/features/product/domain/event/update_product_event.dart';

part 'offer_state.dart';

@injectable
class OfferCubit extends Cubit<OfferState> {
  OfferCubit(this.repository, this._reactiveListener) : super(const OfferInitial());

  final ProductRepository repository;
  final ReactiveListener _reactiveListener;

  void _sendUpdateProductEvent() {
    _reactiveListener.publish(const UpdateProductEvent());
  }

  Future<void> makeOffer({
    required String productId,
    required double price,
  }) async {
    try {
      emit(const OfferLoading());
      await repository.makeOffer(productId, price);
      _sendUpdateProductEvent();
      emit(const OfferSuccess());
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 404) {
        emit(OfferFailure(e.response?.data['message'] as String? ?? 'An error occurred while making the offer'));
      } else {
        emit(const OfferFailure('An error occurred while making the offer'));
      }
    }
  }

  Future<void> makeCounterOffer({
    required String productId,
    required double price,
  }) async {
    try {
      emit(const OfferLoading());
      await repository.makeCounterOffer(productId, price);
      _sendUpdateProductEvent();
      emit(const OfferSuccess());
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 404) {
        emit(OfferFailure(e.response?.data['message'] as String? ?? 'An error occurred while making the counter offer'));
      } else {
        emit(const OfferFailure('An error occurred while making the counter offer'));
      }
    }
  }

  Future<void> acceptOffer(String offerId) async {
    try {
      emit(const OfferLoading());
      await repository.acceptOffer(offerId);
      _sendUpdateProductEvent();
      emit(const OfferSuccess());
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 404) {
        emit(OfferFailure(e.response?.data['message'] as String? ?? 'An error occurre while accepting the offer'));
      } else {
        emit(const OfferFailure('An error occurred while accepting the offer'));
      }
    }
  }

  Future<void> declineOffer(String offerId) async {
    try {
      emit(const OfferLoading());
      await repository.declineOffer(offerId);
      _sendUpdateProductEvent();
      emit(const OfferSuccess());
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 404) {
        emit(OfferFailure(e.response?.data['message'] as String? ?? 'An error occurre while declining the offer'));
      } else {
        emit(const OfferFailure('An error occurred while declining the offer'));
      }
    }
  }

  Future<void> declineCountOffer({
    required String offerId,
  }) async {
    try {
      emit(const OfferLoading());
      await repository.declineCountOffer(offerId);
      _sendUpdateProductEvent();
      emit(const OfferSuccess());
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 404) {
        emit(OfferFailure(e.response?.data['message'] as String? ?? 'An error occurre while declining the counter offer'));
      } else {
        emit(const OfferFailure('An error occurred while declining the counter offer'));
      }
    }
  }

  Future<void> acceptCounterOffer({
    required String counterOfferId,
  }) async {
    try {
      emit(const OfferAcceptLoading());
      await repository.acceptCounterOffer(counterOfferId);
      _sendUpdateProductEvent();
      emit(const OfferSuccess());
    } catch (e) {
      if (e is DioException && e.response?.statusCode != 404) {
        emit(OfferFailure(e.response?.data['message'] as String? ?? 'An error occurre while accepting the counter offer'));
      } else {
        emit(const OfferFailure('An error occurred while accepting the counter offer'));
      }
    }
  }
}
