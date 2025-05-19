import 'package:neighborhood_market/app/utils/errors/exceptions.dart';

abstract class LoginErrors implements Exceptions {
  const LoginErrors();
}

class UserNotValidated extends LoginErrors {
  const UserNotValidated();
}

class PaymentRequired extends LoginErrors {
  const PaymentRequired();
}

class AccountDeactivated extends LoginErrors {
  const AccountDeactivated();
}