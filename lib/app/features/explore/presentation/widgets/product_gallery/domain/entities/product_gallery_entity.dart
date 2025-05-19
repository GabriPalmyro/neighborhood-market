import 'package:equatable/equatable.dart';

class ProductGalleryItemEntity extends Equatable {
  const ProductGalleryItemEntity({
    this.id,
    this.price,
    this.commission,
    this.title,
    this.description,
    this.image,
    this.isLiked = false,
    this.tags = const [],
    this.views,
  });

  final String? id;
  final double? price;
  final double? commission;
  final String? title;
  final String? description;
  final String? image;
  final bool? isLiked;
  final List<String> tags;
  final int? views;

  ProductGalleryItemEntity copyWith({
    String? id,
    double? price,
    double? comission,
    String? title,
    String? description,
    String? image,
    bool? isLiked,
    List<String>? tags,
    int? views,
  }) {
    return ProductGalleryItemEntity(
      id: id ?? this.id,
      price: price ?? this.price,
      commission: comission ?? this.commission,
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
