import 'package:equatable/equatable.dart';

abstract class ComponentResult extends Equatable {
  const ComponentResult();
}

class ContentSuccess extends ComponentResult {
  const ContentSuccess({
    required this.data,
  });

  final dynamic data;

  @override
  List<Object?> get props => [
        data,
      ];
}

class ContentError extends ComponentResult {
  const ContentError({
    required this.error,
    required this.stackTrace,
  });

  final Object? error;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [
        error,
        stackTrace,
      ];
}