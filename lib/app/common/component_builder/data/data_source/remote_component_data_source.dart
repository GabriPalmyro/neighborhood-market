import 'package:neighborhood_market/app/common/component_builder/domain/boundary/data_source/component_data_source.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';
import 'package:neighborhood_market/app/common/network/network.dart';

class RemoteComponentDataSource extends ComponentDataSource {
  RemoteComponentDataSource(
    this.networkProvider,
  );

  final NetworkProvider networkProvider;

  @override
  Future<ComponentResponse> getContent({
    required ComponentRequest request,
  }) async {
    request as LoadContentRequest;
    final instance = await networkProvider.getNetworkInstance();

    try {
      if (request.method == 'get') {
        final response = await instance.get(
          request.endpoint,
          queryParameters: request.queryParams,
        );

        return SuccessResponse.fromJson(response.data);
      } else {
        return ErrorResponse(
          error: 'Method not supported',
          stackTrace: StackTrace.current,
        );
      }
    } on Exception catch (e, s) {
      return ErrorResponse(error: e, stackTrace: s);
    }
  }
}
