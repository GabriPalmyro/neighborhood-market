import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_details_entity.dart';

abstract class PurchaseDetailsRepository {
  Future<PurchaseDetailsEntity> getPurchaseDetails(String purchaseId);
  Future<void> sendReview(String productId, String itemId, String review, int rating);
}