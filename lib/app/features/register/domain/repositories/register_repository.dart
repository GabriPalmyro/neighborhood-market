abstract class RegisterRepository {
  Future<void> registerUser({
    required String email,
    required String phoneNumber,
    required String password,
    required String timezone,
  });
  
  Future<String> verifyOTPCode({
    required String otpCode,
  });

  Future<void> resendOTPCode({
    required String userId,
  });

  Future<void> completeProfile({
    required String userId,
    required String username,
    required String fullName,
    required String birthDate,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String zip,
  });

  Future<String> getTimezone();
}
