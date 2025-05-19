import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/my_purchases/data/model/purchase_details_model.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/boundary/purchase_details_repository.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_details_entity.dart';

@Injectable(as: PurchaseDetailsRepository)
class PurchaseDetailsRepositoryImpl implements PurchaseDetailsRepository {
  PurchaseDetailsRepositoryImpl({required this.provider});
  final NetworkProvider provider;

  @override
  Future<PurchaseDetailsEntity> getPurchaseDetails(String purchaseId) async {
    final network = await provider.getNetworkInstance();

    final response = await network.get(
      '/item/page/purchase/$purchaseId',
    );

    return PurchaseDetailsModel.fromJson(
      response.data,
    ).toEntity();
  }

  @override
  Future<void> sendReview(String toUserId, String itemId, String review, int rating) async {
    final network = await provider.getNetworkInstance();

    await network.post(
      '/review',
      data: {
        'toUser': toUserId,
        'itemId': itemId,
        'comment': review,
        'rating': rating,
      },
    );
  }
}
