import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/boundary/seller_profile_repository.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_review_entity.dart';

part 'seller_reviews_state.dart';

@injectable
class SellerReviewsCubit extends Cubit<SellerReviewsState> {
  SellerReviewsCubit(this.repository) : super(const SellerReviewsInitial());

  final SellerProfileRepository repository;

  Future<void> getSellerReviews(String sellerId) async {
    emit(const SellerReviewsLoading());
    try {
      final review = await repository.getSellerReviews(sellerId);
      emit(SellerReviewsLoaded(review.copyWith(id: sellerId)));
    } catch (e) {
      emit(SellerReviewsError(e.toString(), sellerId));
    }
  }

  Future<void> followSeller(String sellerId) async {
    try {
      final currentState = state;
      if (currentState is SellerReviewsLoaded) {
        emit(
          SellerReviewsLoaded(
            currentState.sellerReview.copyWith(
              header: currentState.sellerReview.header.copyWith(
                isFollowing: true,
              ),
            ),
          ),
        );
      }
      await repository.followSeller(sellerId);
    } catch (_) {}
  }

  Future<void> unfollowSeller(String sellerId) async {
    try {
      final currentState = state;
      if (currentState is SellerReviewsLoaded) {
        emit(
          SellerReviewsLoaded(
            currentState.sellerReview.copyWith(
              header: currentState.sellerReview.header.copyWith(
                isFollowing: false,
              ),
            ),
          ),
        );
      }
      await repository.unfollowSeller(sellerId);
    } catch (_) {}
  }
}
