import 'package:equatable/equatable.dart';

import '../../../../core/data/models/debugging_model.dart';

class ExceptionCatch extends Equatable implements DebuggingModel {
  const ExceptionCatch({
    required this.timestamp,
    required this.errorMessage,
    required this.stackTrace,
    required this.errorType,
  });

  factory ExceptionCatch.fromJson(Map<String, dynamic> json) {
    return ExceptionCatch(
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
      errorMessage: json['errorMessage'],
      stackTrace: json['stackTrace'],
      errorType: json['errorType'],
    );
  }

  final DateTime? timestamp;
  final String? errorMessage;
  final String? stackTrace;
  final String? errorType;

  @override
  List<Object?> get props => [
        timestamp,
        errorMessage,
        stackTrace,
        errorType,
      ];

  ExceptionCatch copyWith({
    DateTime? timestamp,
    String? errorMessage,
    String? stackTrace,
    String? errorType,
  }) {
    return ExceptionCatch(
      timestamp: timestamp ?? this.timestamp,
      errorMessage: errorMessage ?? this.errorMessage,
      stackTrace: stackTrace ?? this.stackTrace,
      errorType: errorType ?? this.errorType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp?.toIso8601String(),
      'errorMessage': errorMessage,
      'stackTrace': stackTrace,
      'errorType': errorType,
    };
  }

  @override
  int compareTo(DebuggingModel other) {
    if (other is ExceptionCatch) {
      return timestamp!.compareTo(other.timestamp!);
    }
    return 0;
  }

  @override
  String get subtitle => errorMessage ?? '';

  @override
  String get title => errorType ?? '';
}
