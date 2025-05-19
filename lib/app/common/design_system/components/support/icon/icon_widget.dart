import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons_data.dart';

enum DSIconSize {
  xs(8),
  sm(16),
  md(24),
  lg(32),
  xl(48);

  const DSIconSize(this.size);
  final double size;
}

class DSIcon extends StatelessWidget {
  const DSIcon({
    required this.icon,
    this.color,
    this.size,
    super.key,
  });

  final IconAssetData icon;
  final Color? color;
  final DSIconSize? size;

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(icon.path),
      color: color,
      size: size?.size,
    );
  }
}
