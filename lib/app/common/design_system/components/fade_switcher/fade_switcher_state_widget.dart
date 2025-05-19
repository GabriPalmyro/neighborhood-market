import 'package:flutter/material.dart';

class FadeSwitcherState<S, R, E, L> extends StatelessWidget {
  const FadeSwitcherState({
    required this.error,
    required this.loading,
    required this.result,
    required this.state,
    this.duration = const Duration(milliseconds: 150),
    super.key,
  });
  final Widget Function(E error) error;
  final Widget Function(L loading) loading;
  final Widget Function(R result) result;
  final S state;
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
      child: () {
        if (state is E) {
          return error(state as E);
        } else if (state is L) {
          return loading(state as L);
        } else if (state is R) {
          return result(state as R);
        }
        return const SizedBox();
      }(),
    );
  }
}
