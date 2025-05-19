import 'package:neighborhood_market/app/features/white_glove/domain/entity/white_glove_item_entity.dart';

class WhiteGloveItemModel extends WhiteGloveItemEntity {
  const WhiteGloveItemModel({
    required super.itemDescription,
    required super.price,
    required super.pickDate,
  });

  factory WhiteGloveItemModel.fromJson(Map<String, dynamic> json) {
    return WhiteGloveItemModel(
      itemDescription: json['itemDescription'],
      price: json['price'],
      pickDate: json['pickDate'],
    );
  }

  WhiteGloveItemEntity toEntity() {
    return WhiteGloveItemEntity(
      itemDescription: itemDescription,
      price: price,
      pickDate: pickDate,
    );
  }
}
