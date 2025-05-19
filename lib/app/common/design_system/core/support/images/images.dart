import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/image_data.dart';

class ThemeImages {
  ThemeImages._();

  static const logoForeground = ImageData(name: 'logo_foreground', fileExtension: 'png');
  static const logo = ImageData(name: 'logo', fileExtension: 'png');
  static const backgroundSplash = ImageData(name: 'background_splash', fileExtension: 'jpeg');
  static const profileBackground = ImageData(name: 'profile_background', fileExtension: 'jpeg');
  static const shirtsMock = ImageData(name: 'shirts_mock', fileExtension: 'jpeg');
  static const sandalsMock = ImageData(name: 'sandals_mock', fileExtension: 'jpeg');
  static const bagMock = ImageData(name: 'bag_mock', fileExtension: 'jpeg');
  static const skirtsMock = ImageData(name: 'skirts_mock', fileExtension: 'jpeg');
  static const shoesMock = ImageData(name: 'shoes_mock', fileExtension: 'jpeg');
  static const womensMock = ImageData(name: 'womens_mock', fileExtension: 'jpeg');
  static const mensMock = ImageData(name: 'mens_mock', fileExtension: 'jpeg');
  static const accessoriesMock = ImageData(name: 'accessories_mock', fileExtension: 'jpeg');
  static const handbagsMock = ImageData(name: 'handbags_mock', fileExtension: 'jpeg');
  static const visaCard = ImageData(name: 'visa_card', fileExtension: 'jpg');
  static const hangerTop = ImageData(name: 'hanger-top', fileExtension: 'png');
  static const hangerBottom = ImageData(name: 'hanger-bottom', fileExtension: 'png');

  static ImageData fromString(String name) {
    return ImageData(name: name);
  }
}

class ImageData {
  const ImageData({
    required this.name,
    this.fileExtension = 'jpeg',
  });

  final String name;
  final String fileExtension;

  AssetImage assetImage(String name) {
    final asset = ImageAssetData(name: name, fileExtension: fileExtension);
    return AssetImage(asset.path);
  }
}
