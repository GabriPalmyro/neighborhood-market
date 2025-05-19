import 'package:flutter_test/flutter_test.dart';
import 'package:neighborhood_market/app/common/regex/regex.dart';

void main() {
  group('PasswordRegEx', () {
    test('passwordNoNumber should match any digit', () {
      expect(PasswordRegEx.passwordNoNumber.hasMatch('123'), isTrue);
      expect(PasswordRegEx.passwordNoNumber.hasMatch('abc'), isFalse);
    });

    test('passwordNoLetter should match any letter', () {
      expect(PasswordRegEx.passwordNoLetter.hasMatch('abc'), isTrue);
      expect(PasswordRegEx.passwordNoLetter.hasMatch('123'), isFalse);
    });

    test('passwordTooSimple should match only alphanumeric strings', () {
      expect(PasswordRegEx.passwordTooSimple.hasMatch('abc123'), isTrue);
      expect(PasswordRegEx.passwordTooSimple.hasMatch('abc123!'), isFalse);
    });
  });

  group('EmailRegEx', () {
    test('email should match valid email addresses', () {
      expect(EmailRegEx.email.hasMatch('test@example.com'), isTrue);
      expect(EmailRegEx.email.hasMatch('invalid-email'), isFalse);
    });
  });
}