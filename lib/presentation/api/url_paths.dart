class ApiPaths {
  // Base URL
  static const String baseUrl = 'http://137.184.95.36:8020';

  // Endpoints
  static const String signinUrl = '$baseUrl/api/v1/auth/local';
  static const String signupUrl = '$baseUrl/api/v1/auth/sign-up';
  static const String verifyEmailUrl = '$baseUrl/api/v1/auth/verify-email';
  static const String forgetPasswordUrl =
      '$baseUrl/api/v1/auth/forget-password';
  static const String verifyOtpUrl = '$baseUrl/api/v1/auth/verify-otp';
  static const String resetPasswordUrl = '$baseUrl/api/v1/auth/reset-password';
  static const String changePasswordUrl =
      '$baseUrl/api/v1/auth/change-password';
  static const String updateProfileUrl = '$baseUrl/api/v1/users/';
  static const String profileUrl = '$baseUrl/api/v1/users/user-details';
}
