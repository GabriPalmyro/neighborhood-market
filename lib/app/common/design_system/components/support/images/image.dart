import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';

class ThemeImage extends StatelessWidget {
  const ThemeImage(
    this.image, {
    super.key,
    this.size,
    this.fit,
    this.alignment = Alignment.center,
    this.colorBlendMode = BlendMode.srcIn,
    this.color,
  });

  final ImageData image;

  final Size? size;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final BlendMode? colorBlendMode;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final asset = image.assetImage(image.name);
    return Image.asset(
      asset.assetName,
      width: size?.width,
      height: size?.height,
      fit: fit,
      alignment: alignment,
      colorBlendMode: colorBlendMode,
      color: color,
    );
  }
}
