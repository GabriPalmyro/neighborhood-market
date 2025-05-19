import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/my_purchases/domain/entities/purchase_delivery_item_entity.dart';

class PurchaseDeliveryItemModel extends Equatable {
  const PurchaseDeliveryItemModel({
    required this.title,
    required this.isFinished,
    required this.date,
    required this.time,
  });

  factory PurchaseDeliveryItemModel.fromJson(Map<String, dynamic> json) {
    return PurchaseDeliveryItemModel(
      title: json['title'],
      isFinished: json['status'] == 'finished',
      date: json['date'],
      time: json['time'],
    );
  }

  final String title;
  final bool isFinished;
  final String date;
  final String time;

  PurchaseDeliveryItemEntity toEntity() {
    return PurchaseDeliveryItemEntity(
      title: title,
      isFinished: isFinished,
      date: date,
      time: time,
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      isFinished,
      date,
      time,
    ];
  }
}
