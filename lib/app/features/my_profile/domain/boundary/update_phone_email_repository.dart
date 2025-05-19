abstract class UpdatePhoneEmailRepository {
  Future<void> sendCodeToNewPhone(String newPhone);
  Future<void> sendCodeToNewEmail(String newEmail);
  Future<void> verifyCode(String verifyCode);
}