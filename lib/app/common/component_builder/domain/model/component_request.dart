import 'package:equatable/equatable.dart';

abstract class ComponentRequest extends Equatable {
  const ComponentRequest();
}

class LoadContentRequest extends ComponentRequest {
  const LoadContentRequest({
    required this.endpoint,
    this.method = 'get',
    this.queryParams,
  });

  final String endpoint;
  final String method;
  final Map<String, dynamic>? queryParams;

  @override
  List<Object?> get props => [endpoint, method, queryParams];
}
