import 'package:flutter/material.dart';

class StarReviewStyle {
  const StarReviewStyle();

  Color barColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFF45B171);
      case 1:
        return const Color(0xFF58A3D8);
      case 2:
        return const Color(0xFFF5E42A);
      case 3:
        return const Color(0xFFE2783F);
      case 4:
        return const Color(0xFFDF2121);
      default:
        return const Color(0xFFDF2121);
    }
  }
}
