import 'package:equatable/equatable.dart';

class WhiteGloveItemEntity extends Equatable {
  const WhiteGloveItemEntity({
    this.itemDescription,
    this.price,
    this.pickDate,
  });

  final String? itemDescription;
  final String? price;
  final DateTime? pickDate;

  Map<String, dynamic> toJson() {
    return {
      'description': itemDescription,
      'price': price,
      'pickUpDate': pickDate?.toIso8601String(),
    };
  }

  WhiteGloveItemEntity copyWith({
    String? itemDescription,
    String? price,
    DateTime? pickDate,
  }) {
    return WhiteGloveItemEntity(
      itemDescription: itemDescription ?? this.itemDescription,
      price: price ?? this.price,
      pickDate: pickDate ?? this.pickDate,
    );
  }

  @override
  List<Object?> get props => [itemDescription, price, pickDate];
}
