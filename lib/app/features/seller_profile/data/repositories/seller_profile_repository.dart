import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/seller_profile/data/model/seller_profile_model.dart';
import 'package:neighborhood_market/app/features/seller_profile/data/model/seller_review_entity.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/boundary/seller_profile_repository.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_profile_entity.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_review_entity.dart';

@Injectable(as: SellerProfileRepository)
class SellerProfileRepositoryImpl implements SellerProfileRepository {
  SellerProfileRepositoryImpl({required this.provider});
  final NetworkProvider provider;

  @override
  Future<SellerProfileEntity> getSellerProfile(String sellerId) async {
    final network = await provider.getNetworkInstance();
    final response = await network.get(
      '/user/page/seller/$sellerId',
    );

    return SellerProfileModel.fromJson(
      response.data,
    ).toEntity();
  }

  @override
  Future<SellerReviewEntity> getSellerReviews(String sellerId) async {
    final network = await provider.getNetworkInstance();
    final response = await network.get(
      '/user/page/seller/review/$sellerId',
    );

    return SellerReviewModel.fromJson(
      response.data,
    ).toEntity();
  }
  
  @override
  Future<void> followSeller(String sellerId) async {
    final network = await provider.getNetworkInstance();
    await network.post('/follow/$sellerId');
  }
  
  @override
  Future<void> unfollowSeller(String sellerId) async {
    final network = await provider.getNetworkInstance();
    await network.post('/unfollow/$sellerId');
  }
}
