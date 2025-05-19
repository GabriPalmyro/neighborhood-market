import '../../../../core/data/factory/debugging_model_factory.dart';
import '../../../../core/data/models/debugging_model.dart';
import '../models/exception_catch.dart';

class ExceptionCatchFactory implements DebuggingModelFactory {
  @override
  DebuggingModel createFromJson(Map<String, dynamic> json) {
    return ExceptionCatch.fromJson(json);
  }
}
