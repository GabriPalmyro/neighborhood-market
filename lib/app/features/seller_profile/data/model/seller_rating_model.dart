import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/common/formatter/price_formatter.dart';
import 'package:neighborhood_market/app/features/seller_profile/domain/entities/seller_rating_entity.dart';

class SellerRatingModel extends Equatable {
  const SellerRatingModel({
    required this.total,
    required this.average,
    required this.averageStarItems,
  });

  factory SellerRatingModel.fromJson(Map<String, dynamic> json) {
    final List<AverageStarItemModel> averageStarItems = [];
    for (final item in json['averageStars'] as List<dynamic>) {
      averageStarItems.add(AverageStarItemModel.fromJson(item));
    }

    return SellerRatingModel(
      total: json['total'] as int,
      average: (json['average'] is String)
          ? (json['average'] as String).parseToDouble()
          : (json['average'] is int)
              ? (json['average'] as int).toDouble()
              : json['average'] as double,
      averageStarItems: averageStarItems,
    );
  }

  final int total;
  final double average;
  final List<AverageStarItemModel> averageStarItems;

  SellerRatingEntity toEntity() {
    return SellerRatingEntity(
      total: total,
      average: average,
      averageStarItems: averageStarItems.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object> get props => [
        total,
        average,
        averageStarItems,
      ];
}

class AverageStarItemModel extends Equatable {
  const AverageStarItemModel({
    required this.label,
    required this.value,
  });

  factory AverageStarItemModel.fromJson(Map<String, dynamic> json) {
    return AverageStarItemModel(
      label: json['label'],
      value: json['value'],
    );
  }

  final String label;
  final int value;

  AverageStarItemEntity toEntity() {
    return AverageStarItemEntity(
      label: label,
      value: value,
    );
  }

  @override
  List<Object> get props => [
        label,
        value,
      ];
}
