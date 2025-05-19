import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ProductItemProps extends Equatable {
  const ProductItemProps({
    required this.title,
    required this.imageUrl,
    required this.badges,
    this.trailing,
    this.price,
    this.isValueCheck = false,
    this.views,
  });

  final String title;
  final String? imageUrl;
  final List<String> badges;
  final double? price;
  final Widget? trailing;
  final bool isValueCheck;
  final int? views;

  @override
  List<Object?> get props => [
        title,
        imageUrl,
        badges,
        price,
        trailing,
        isValueCheck,
        views,
      ];
}
