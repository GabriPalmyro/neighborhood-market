import 'package:neighborhood_market/app/utils/data/item_types.dart';

enum ProductType {
  clothing,
  shoes,
  accessories;

  static ProductType fromString(String value) {
    final clothingCategories = (itemTypes[0]['items'] as List<dynamic>)
        .map(
          (e) => e['name'],
        )
        .toList();

    final shoeCategories = (itemTypes[1]['items'] as List<dynamic>)
        .map(
          (e) => e['name'],
        )
        .toList();

    if (clothingCategories.contains(value)) {
      return ProductType.clothing;
    } else if (shoeCategories.contains(value)) {
      return ProductType.shoes;
    } else {
      return ProductType.accessories;
    }
  }
}
