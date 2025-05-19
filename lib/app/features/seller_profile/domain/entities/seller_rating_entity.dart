import 'package:equatable/equatable.dart';

class SellerRatingEntity extends Equatable {
  const SellerRatingEntity({
    required this.total,
    required this.average,
    required this.averageStarItems,
  });

  final int total;
  final double average;
  final List<AverageStarItemEntity> averageStarItems;

  @override
  List<Object> get props => [
        total,
        average,
        averageStarItems,
      ];
}

class AverageStarItemEntity extends Equatable {
  const AverageStarItemEntity({
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  @override
  List<Object> get props => [
        label,
        value,
      ];
}
