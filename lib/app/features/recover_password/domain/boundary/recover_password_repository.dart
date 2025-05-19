abstract class RecoverPasswordRepository {
  Future<void> sendCodeToEmail(String email);
  Future<String> validateRecoveryCode(String code);
  Future<void> resetPassword(
    String email,
    String newPassword,
    String jwt,
  );
}
