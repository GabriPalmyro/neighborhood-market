import 'package:neighborhood_market/app/common/component_builder/data/component_repository_default.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/boundary/component_repository.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/boundary/component_repository_factory.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/boundary/data_source/component_data_source.dart';

class ComponentRepositoryFactoryDefault implements ComponentRepositoryFactory {
  late ComponentDataSource _remoteDataSource;
 
  @override
  void addRemoteDataSource(ComponentDataSource source) {
    _remoteDataSource = source;
  }

  @override
  ComponentRepository create() {
    return ComponentRepositoryDefault(_remoteDataSource);
  }
}
