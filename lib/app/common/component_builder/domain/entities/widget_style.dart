import 'package:equatable/equatable.dart';

final class WidgetStyle extends Equatable {

  const WidgetStyle({
    required this.bounds,
    this.backgroundColor,
  });

  factory WidgetStyle.fromMap(Map<String, dynamic> map) {
    return WidgetStyle(
      bounds: WidgetBounds.fromMap(map['bounds']),
      backgroundColor: map['backgroundColor'],
    );
  }
  
  final WidgetBounds bounds;
  final String? backgroundColor;

  @override
  List<Object?> get props => [bounds, backgroundColor];
}

final class WidgetBounds extends Equatable {

  const WidgetBounds({
    this.top,
    this.left,
    this.bottom,
    this.right,
  });

  factory WidgetBounds.fromMap(Map<String, dynamic> map) {
    return WidgetBounds(
      top: map['top'],
      left: map['left'],
      bottom: map['bottom'],
      right: map['right'],
    );
  }

  final String? top;
  final String? left;
  final String? bottom;
  final String? right;

  @override
  List<Object?> get props => [top, left, bottom, right];
}