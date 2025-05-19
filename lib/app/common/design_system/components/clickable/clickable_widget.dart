import 'package:flutter/material.dart';

class ClickableWidget extends StatelessWidget {
  const ClickableWidget({
    required this.borderRadius,
    required this.onTap,
    required this.child,
    this.padding,
    super.key,
  });

  final BorderRadius borderRadius;
  final GestureTapCallback? onTap;
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
