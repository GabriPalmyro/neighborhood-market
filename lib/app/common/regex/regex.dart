class PasswordRegEx {
  PasswordRegEx._();
  static final RegExp passwordNoNumber = RegExp(r'[0-9]');
  static final RegExp passwordNoLetter = RegExp(r'[a-zA-Z]');
  static final RegExp passwordTooSimple = RegExp(r'^[a-zA-Z0-9]+$');
}

class EmailRegEx {
  EmailRegEx._();
  static final RegExp email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}