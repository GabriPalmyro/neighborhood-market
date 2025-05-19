import 'package:equatable/equatable.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/product_gallery/domain/entities/product_gallery_entity.dart';

class ProductGalleryItemModel extends Equatable {
  const ProductGalleryItemModel({
    this.id,
    this.price,
    this.commission,
    this.title,
    this.description,
    this.image,
    // this.deeplink,
    this.isLiked = false,
    this.tags = const [],
    this.views,
  });

  factory ProductGalleryItemModel.fromJson(Map<String, dynamic> json) {
    return ProductGalleryItemModel(
      id: json['id'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] as double?,
      commission: (json['commission'] is int) ? (json['comissicommissionon'] as int).toDouble() : json['commission'] as double?,
      title: json['title'] as String? ?? json['name'] as String? ?? '',
      description: json['description'] as String?,
      image: json['images'] != null
          ? (json['images'] as List<dynamic>?)?.first as String?
          : (json['image'] is String?)
              ? (json['image'] as String?)
              : (json['image'] as List<dynamic>?)?.first as String?,
      isLiked: json['isLiked'],
      views: json['views'],
      tags: List<String>.from(json['tags']?.map((tag) => tag ?? '') ?? []),
    );
  }

  final String? id;
  final double? price;
  final double? commission;
  final String? title;
  final String? description;
  final String? image;
  final bool? isLiked;
  final List<String> tags;
  final int? views;

  ProductGalleryItemEntity toEntity() {
    return ProductGalleryItemEntity(
      id: id,
      price: price,
      commission: commission,
      title: title,
      description: description,
      image: image,
      isLiked: isLiked,
      tags: tags,
      views: views,
    );
  }

  ProductGalleryItemModel copyWith({
    String? id,
    double? price,
    double? commission,
    String? title,
    String? description,
    String? image,
    bool? isLiked,
    List<String>? tags,
    int? views,
  }) {
    return ProductGalleryItemModel(
      id: id ?? this.id,
      price: price ?? this.price,
      commission: commission ?? this.commission,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      isLiked: isLiked ?? this.isLiked,
      tags: tags ?? this.tags,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [
        id,
        price,
        commission,
        title,
        description,
        image,
        isLiked,
        tags,
        views,
      ];
}
