import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/boundary/seller_profile_repository.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_profile_entity.dart';

part 'seller_profile_state.dart';

@injectable
class SellerProfileCubit extends Cubit<SellerProfileState> {
  SellerProfileCubit(this.repository) : super(const SellerProfileInitial());
  final SellerProfileRepository repository;

  Future<void> getSellerProfile(String sellerId) async {
    emit(const SellerProfileLoading());
    try {
      final sellerProfile = await repository.getSellerProfile(sellerId);
      emit(SellerProfileLoaded(sellerProfile.copyWith(sellerId: sellerId)));
    } catch (e) {
      emit(SellerProfileError(e.toString(), sellerId));
    }
  }

  Future<void> followSeller(String sellerId) async {
    try {
      final currentState = state;
      if (currentState is SellerProfileLoaded) {
        final updatedSeller = currentState.sellerProfile.copyWith(isFollowing: true);
        emit(SellerProfileLoaded(updatedSeller));
      }
      await repository.followSeller(sellerId);
    } catch (_) {}
  }

  Future<void> unfollowSeller(String sellerId) async {
    try {
      final currentState = state;
      if (currentState is SellerProfileLoaded) {
        final updatedSeller = currentState.sellerProfile.copyWith(isFollowing: false);
        emit(SellerProfileLoaded(updatedSeller));
      }
      await repository.unfollowSeller(sellerId);
    } catch (_) {}
  }
}
