import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_profile_entity.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_review_entity.dart';

abstract class SellerProfileRepository {
  Future<SellerProfileEntity> getSellerProfile(String sellerId);
  Future<SellerReviewEntity> getSellerReviews(String sellerId);
  Future<void> followSeller(String sellerId);
  Future<void> unfollowSeller(String sellerId);
}