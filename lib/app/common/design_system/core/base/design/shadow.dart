import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/core/tokens/design/shadow.dart';

class BaseShadow implements DSShadow {
  BaseShadow();

  @override
  BoxShadow normal = BoxShadow(
    color: Colors.black.withValues(alpha: 0.07),
    offset: const Offset(0, 4),
    blurRadius: 4,
  );
}
