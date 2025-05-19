import 'package:equatable/equatable.dart';

enum ShopGalleryType {
  trending,
  mostWanted,
  followedItems,
}

class ShopGalleryModel extends Equatable {
  const ShopGalleryModel({
    this.title,
    this.actionLabel,
    this.items = const [],
    this.type,
  });

  factory ShopGalleryModel.fromJson(Map<String, dynamic> json, ShopGalleryType? type) {
    return ShopGalleryModel(
      title: json['title'],
      actionLabel: json['actionLabel'],
      type: type,
      items: (json['items'] as List<dynamic>?)
              ?.map(
                (item) => ShopGalleryItemModel.fromJson(item),
              )
              .toList() ??
          [],
    );
  }

  final String? title;
  final String? actionLabel;
  final List<ShopGalleryItemModel> items;
  final ShopGalleryType? type;

  ShopGalleryModel copyWith({
    String? title,
    String? actionLabel,
    List<ShopGalleryItemModel>? items,
    ShopGalleryType? type,
  }) {
    return ShopGalleryModel(
      title: title ?? this.title,
      actionLabel: actionLabel ?? this.actionLabel,
      items: items ?? this.items,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        title,
        actionLabel,
        items,
        type,
      ];
}

class ShopGalleryItemModel extends Equatable {
  const ShopGalleryItemModel({
    required this.id,
    this.price,
    this.title,
    this.image,
    this.action = '',
    this.isLiked = false,
    this.tags = const [],
  });

  factory ShopGalleryItemModel.fromJson(Map<String, dynamic> json) {
    return ShopGalleryItemModel(
      id: json['id'] ?? '',
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] as double,
      title: json['title'] as String? ?? json['name'] as String? ?? '',
      image: json['image'] as String? ?? (json['images'] as List<dynamic>?)?.first as String?,
      isLiked: json['isLiked'],
      action: json['action'],
      tags: (json['tags'] as List<dynamic>?)
              ?.map(
                (tag) => tag.toString(),
              )
              .toList() ??
          [],
    );
  }

  ShopGalleryItemModel copyWith({
    String? id,
    double? price,
    String? title,
    String? image,
    bool? isLiked,
    String? action,
    List<String>? tags,
  }) {
    return ShopGalleryItemModel(
      id: id ?? this.id,
      price: price ?? this.price,
      title: title ?? this.title,
      image: image ?? this.image,
      isLiked: isLiked ?? this.isLiked,
      action: action ?? this.action,
      tags: tags ?? this.tags,
    );
  }

  final String id;
  final double? price;
  final String? title;
  final String? image;
  final bool isLiked;
  final String? action;
  final List<String> tags;

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        price,
        isLiked,
        action,
        tags,
      ];
}
