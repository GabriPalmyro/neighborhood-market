import 'package:neighborhood_market/app/common/xdebugging/core/data/data_source/shared_preferences_data_source.dart';
import 'package:neighborhood_market/app/common/xdebugging/core/data/repository/shared_preferences_repository.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/error/data/factories/api_responde_factory.dart';

class ExceptionModule {
  final String _kApiKey = 'xDebuggingException';

  SharedPreferencesDataSource get dataSource => SharedPreferencesDataSource(
        factory: ExceptionCatchFactory(),
        preferenceKey: _kApiKey,
      );

  SharedPreferencesRepository get repository => SharedPreferencesRepository(
        dataSource: dataSource,
      );
}
