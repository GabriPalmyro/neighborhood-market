import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/notifications/domain/entities/notification_entity.dart';

class NotificationActionDataModel extends Equatable {
  const NotificationActionDataModel({
    this.itemId,
    this.itemName,
    this.offerId,
    this.offerPrice,
  });

  factory NotificationActionDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationActionDataModel(
      itemId: json['itemId'] as String?,
      itemName: json['name'] as String?,
      offerId: json['offerId'] as String?,
      offerPrice: (json['offerPrice'] is int) ? (json['offerPrice'] as int).toDouble() : json['offerPrice'] as double?,
    );
  }

  final String? itemId;
  final String? itemName;
  final String? offerId;
  final double? offerPrice;

  NotificationActionDataEntity toEntity() {
    return NotificationActionDataEntity(
      itemId: itemId,
      itemName: itemName,
      offerId: offerId,
      offerPrice: offerPrice,
    );
  }

  @override
  List<Object?> get props => [
        itemId,
        itemName,
        offerId,
        offerPrice,
      ];
}

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.date,
    this.remainingSeconds,
    this.isRead = false,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      type: json['type'] != null ? NotificationActionType.fromString(json['type'] as String) : null,
      title: json['title'] as String,
      message: json['message'] as String,
      date: DateTime.parse(json['createdAt'] as String),
      isRead: json['read'] as bool? ?? false,
      remainingSeconds: json['remainingSeconds'] as int?,
      data: json['data'] != null ? NotificationActionDataModel.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  final String id;
  final NotificationActionType? type;
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;
  final int? remainingSeconds;
  final NotificationActionDataModel? data;

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      type: type,
      title: title,
      message: message,
      date: date,
      isRead: isRead,
      remainingSeconds: remainingSeconds,
      data: data?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        message,
        date,
        isRead,
        remainingSeconds,
        data,
      ];
}
