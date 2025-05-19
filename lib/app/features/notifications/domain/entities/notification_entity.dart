import 'package:equatable/equatable.dart';

enum NotificationActionType {
  unknown,
  itemBought,
  itemSent,
  ongoingOffer,
  offerReceived,
  counterOfferSent,
  counterOfferReceived,
  countOfferAccepted,
  countOfferDenied,
  offerAccepted,
  offerDenied,
  itemDelivered,
  newItem;

  static NotificationActionType fromString(String value) {
    switch (value) {
      case 'ongoingOffer':
        return NotificationActionType.ongoingOffer;
      case 'offerReceived':
        return NotificationActionType.offerReceived;
      case 'counterOfferSent':
        return NotificationActionType.counterOfferSent;
      case 'counterOfferReceived':
        return NotificationActionType.counterOfferReceived;
      case 'offerAccepted':
        return NotificationActionType.offerAccepted;
      case 'offerDenied':
        return NotificationActionType.offerDenied;
      case 'itemDelivered':
        return NotificationActionType.itemDelivered;
      case 'itemBought':
        return NotificationActionType.itemBought;
      case 'itemSent':
        return NotificationActionType.itemSent;
      case 'countOfferAccepted':
        return NotificationActionType.countOfferAccepted;
      case 'countOfferDenied':
        return NotificationActionType.countOfferDenied;
      case 'newItem':
        return NotificationActionType.newItem;
      default:
        return NotificationActionType.unknown;
    }
  }
}

class NotificationActionDataEntity extends Equatable {
  const NotificationActionDataEntity({
    this.itemId,
    this.itemName,
    this.offerId,
    this.offerPrice,
  });

  final String? itemId;
  final String? itemName;
  final String? offerId;
  final double? offerPrice;

  @override
  List<Object?> get props => [
        itemId,
        itemName,
        offerId,
        offerPrice,
      ];
}

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.date,
     this.isRead = false,
    this.remainingSeconds,
    this.data,
  });

  final String id;
  final NotificationActionType? type;

  final String title;
  final String message;
  final DateTime date;
  final bool isRead;
  final int? remainingSeconds;
  final NotificationActionDataEntity? data;

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
