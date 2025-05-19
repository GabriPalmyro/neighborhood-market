import 'package:neighborhood_market/app/common/component_builder/domain/boundary/component_repository.dart';
import 'package:neighborhood_market/app/common/component_builder/domain/boundary/data_source/component_data_source.dart';

abstract class ComponentRepositoryFactory {
  void addRemoteDataSource(ComponentDataSource source);
  ComponentRepository create();
}
