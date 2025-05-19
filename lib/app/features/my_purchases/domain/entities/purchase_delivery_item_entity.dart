import 'package:equatable/equatable.dart';

class PurchaseDeliveryItemEntity extends Equatable {
  const PurchaseDeliveryItemEntity({
    required this.title,
    required this.isFinished,
    required this.date,
    required this.time,
  });

  final String title;
  final bool isFinished;
  final String date;
  final String time;

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
