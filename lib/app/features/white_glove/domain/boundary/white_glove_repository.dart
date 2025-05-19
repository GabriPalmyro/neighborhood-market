import 'package:neighborhood_market/app/features/white_glove/domain/entity/white_glove_item_entity.dart';

abstract class WhiteGloveRepository {
  Future<void> requestWhiteGlove(List<WhiteGloveItemEntity> items);
}
