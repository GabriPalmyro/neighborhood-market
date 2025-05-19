import 'package:neighborhood_market/app/core/app_consts.dart';

extension CommissionExtension on double {
  double calculateStandartCommission() {
    return this - (this * AppConsts.standartCommission);
  }

  double calculateWhiteGloveCommission() {
    return this - (this * AppConsts.whiteGloveCommission);
  }
}
