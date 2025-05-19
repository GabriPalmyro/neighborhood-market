import 'package:flutter/material.dart';

abstract class DSShadow {
  DSShadow({
    required this.normal,
  });

  final BoxShadow normal;
}
