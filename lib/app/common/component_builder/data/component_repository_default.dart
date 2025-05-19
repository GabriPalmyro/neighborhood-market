import 'package:neighborhood_market/app/common/component_builder/domain/boundary/component_repository.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/boundary/data_source/component_data_source.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_request.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/model/component_response.dart';

class ComponentRepositoryDefault extends ComponentRepository {
  ComponentRepositoryDefault(
    this.dataSource,
  );

  final ComponentDataSource dataSource;

  @override
  Future<ComponentResponse> getContent(
    ComponentRequest request,
  ) async {
    return dataSource.getContent(request: request);
  }
}
