import 'package:equatable/equatable.dart';

abstract class ComponentResponse extends Equatable {
  const ComponentResponse();
}

class SuccessResponse extends ComponentResponse {
  const SuccessResponse({
    required this.data,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(data: json);
  }

  final dynamic data;

  @override
  List<Object?> get props => [
        data,
      ];
}

class ErrorResponse extends ComponentResponse {
  const ErrorResponse({
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
