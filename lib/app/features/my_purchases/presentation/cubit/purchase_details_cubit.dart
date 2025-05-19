import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/boundary/purchase_details_repository.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_details_entity.dart';

part 'purchase_details_state.dart';

@injectable
class PurchaseDetailsCubit extends Cubit<PurchaseDetailsState> {
  PurchaseDetailsCubit(this.repository) : super(const PurchaseDetailsInitial());

  final PurchaseDetailsRepository repository;

  Future<void> loadPurchaseDetails(String purchaseId) async {
    emit(const PurchaseDetailsLoading());
    try {
      final purchase = await repository.getPurchaseDetails(purchaseId);
      emit(PurchaseDetailsLoaded(purchase));
    } catch (e) {
      emit(const PurchaseDetailsError('Error loading purchase details'));
    }
  }

  void changeReviewStatus() {
    if (state is PurchaseDetailsLoaded) {
      final purchase = (state as PurchaseDetailsLoaded).purchase;
      emit(
        PurchaseDetailsLoaded(
          purchase.copyWith(
            hasBeenReviewed: true,
          ),
        ),
      );
    }
  }
}
