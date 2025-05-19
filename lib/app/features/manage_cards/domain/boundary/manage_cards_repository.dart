import 'package:neighborhood_market/app/features/manage_cards/domain/entities/manage_cards_entity.dart';

abstract class ManageCardsRepository {
  Future<ManageCardsEntity> getManageCards({
    required String userId,
  });
}
