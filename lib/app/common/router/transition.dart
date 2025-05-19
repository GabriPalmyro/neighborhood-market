import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

enum PageTransition {
  none(_noTransition),
  upwards(_upwardsTransition),
  transparent(_defaultTransition),
  rightToLeft(_rightToLeftTransition);

  const PageTransition(this.builder);

  final CustomTransitionPage<dynamic> Function(Widget page) builder;
}

const _defaultTransitionDuration = Duration(milliseconds: 200);
const _defaultCurve = Curves.easeInOut;

const _beginRight = Offset(1.0, 0.0);
const _beginBottom = Offset(0.0, 1.0);

CustomTransitionPage<dynamic> _noTransition(Widget page) => NoTransitionPage(
      child: page,
    );

CustomTransitionPage<dynamic> _upwardsTransition(Widget page) => CustomTransitionPage(
      child: page,
      transitionDuration: _defaultTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: _beginBottom, end: Offset.zero);
        final curvedAnimation = CurvedAnimation(parent: animation, curve: _defaultCurve);

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );

CustomTransitionPage<dynamic> _rightToLeftTransition(Widget page) => CustomTransitionPage(
      child: page,
      transitionDuration: _defaultTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: _beginRight, end: Offset.zero);
        final curvedAnimation = CurvedAnimation(parent: animation, curve: _defaultCurve);

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );

CustomTransitionPage<dynamic> _defaultTransition(Widget page) => CustomTransitionPage(
      child: page,
      opaque: false,
      fullscreenDialog: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
    );
