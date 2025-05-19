import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/home/di/home_external_modules.dart';
import 'package:neighborhood_market/app/features/profile/di/profile_external_modules.dart';

const List<ExternalModule> externalModules = [
  ...homeExternalModules,
  ...profileExternalModules,
];
