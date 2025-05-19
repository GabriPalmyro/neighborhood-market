import 'package:flutter/material.dart';

class FadeSwitcher extends StatelessWidget {
  const FadeSwitcher({
    required this.child,
    this.duration = const Duration(milliseconds: 150),
    super.key,
  });
  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (widget, animation) {
        return FadeTransition(
          opacity: animation,
          child: widget,
        );
      },
      child: child,
    );
  }
}
