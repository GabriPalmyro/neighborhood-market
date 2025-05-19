import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/boundary/purchase_details_repository.dart';

part 'review_product_state.dart';

@injectable
class ReviewProductCubit extends Cubit<ReviewProductState> {
  ReviewProductCubit(this.repository) : super(const ReviewProductInitial());

  final PurchaseDetailsRepository repository;

  Future<void> loadReviewProduct(
    String toUserId,
    String itemId,
    String comment,
    int rating,
  ) async {
    try {
      emit(const ReviewProductLoading());
      await repository.sendReview(
        toUserId,
        itemId,
        comment,
        rating,
      );
      emit(const ReviewProductLoaded());
    } on DioException catch (e) {
      emit(ReviewProductError(e.response?.data['message']));
    } catch (e) {
      emit(const ReviewProductError('Error loading review product'));
    }
  }
}
