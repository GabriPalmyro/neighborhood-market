import 'package:flutter/widgets.dart';

typedef ModelWidgetBuilder<M, P> = Future<M> Function(P provider);

typedef SuccessBuilder<M> = Widget Function(BuildContext context, M model);

typedef LoadingBuilder = Widget Function(BuildContext context);

typedef ErrorBuilder = Widget Function(BuildContext context, Object? error, StackTrace? stackTrace);

class OnRetryAction extends ValueNotifier<bool> {
  OnRetryAction() : super(false);

  void call() {
    value = true;
  }

  void reset() {
    value = false;
  }
}

class DynamicWidgetBuilder<M, P> extends StatefulWidget {
  const DynamicWidgetBuilder({
    required this.provider,
    required this.modelWidgetBuilder,
    required this.successBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.onRetryAction,
    super.key,
  });

  final P provider;
  final ModelWidgetBuilder<M, P> modelWidgetBuilder;
  final SuccessBuilder<M> successBuilder;
  final LoadingBuilder? loadingBuilder;
  final ErrorBuilder? errorBuilder;
  final OnRetryAction? onRetryAction;

  @override
  State<DynamicWidgetBuilder<M, P>> createState() => _DynamicWidgetBuilderState<M, P>();
}

class _DynamicWidgetBuilderState<M, P> extends State<DynamicWidgetBuilder<M, P>> {
  late P _provider;

  @override
  void initState() {
    _provider = widget.provider;
    widget.onRetryAction?.addListener(_listenToTapError);
    super.initState();
  }

  @override
  void dispose() {
    widget.onRetryAction?.removeListener(_listenToTapError);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.modelWidgetBuilder(_provider),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingBuilder?.call(context) ?? const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return widget.errorBuilder?.call(context, snapshot.error, snapshot.stackTrace) ?? const SizedBox.shrink();
        } else {
          return widget.successBuilder(context, snapshot.data as M);
        }
      },
    );
  }

  void _listenToTapError() {
    setState(() {
      _provider = widget.provider;
      widget.onRetryAction?.reset();
    });
  }
}
