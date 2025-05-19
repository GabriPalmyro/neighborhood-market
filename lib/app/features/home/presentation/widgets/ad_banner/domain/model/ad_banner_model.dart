import 'package:equatable/equatable.dart';

class AdBannerModel extends Equatable {
  const AdBannerModel({
    required this.imageUrl,
    required this.redirectUrl,
  });

  factory AdBannerModel.fromJson(Map<String, dynamic> json) {
    return AdBannerModel(
      imageUrl: json['imageUrl'],
      redirectUrl: json['redirectUrl'],
    );
  }

  final String imageUrl;
  final String? redirectUrl;

  @override
  List<Object?> get props => [
        imageUrl,
        redirectUrl,
      ];
}
