class ApiPaths {
  static const String baseUrl = 'http://10.0.70.87:8020';
  static const String socketUrl = 'http://10.0.70.37:8020';

  static const String signinUrl = '$baseUrl/api/v1/auth/local';
  static const String signupUrl = '$baseUrl/api/v1/auth/sign-up';
  static const String verifyEmailUrl = '$baseUrl/api/v1/auth/verify-email';
  static const String completeProfile = '$baseUrl/api/v1/users/complete';
  static const String forgetPasswordUrl =
      '$baseUrl/api/v1/auth/forget-password';
  static const String verifyOtpUrl = '$baseUrl/api/v1/auth/verify-otp';
  static const String resendOtp = '$baseUrl/api/v1/auth/resend-otp';
  static const String resetPasswordUrl = '$baseUrl/api/v1/auth/reset-password';
  static const String changePasswordUrl =
      '$baseUrl/api/v1/auth/change-password';
  static const String updateProfileUrl = '$baseUrl/api/v1/users/';
  static const String profileUrl = '$baseUrl/api/v1/users/user-details';
  static const String createLoad = '$baseUrl/api/v1/loads/';
  static const String preferredDriver = '$baseUrl/api/v1/loads-request/';
  static const String userSupport = '$baseUrl/api/v1/support/';
  static const String shipingHistory = '$baseUrl/api/v1/shipment/history';
  static String staticContent({contentType}) =>
      '$baseUrl/api/v1/static-contents?type=$contentType';
  static const String currentShiping = '$baseUrl/api/v1/shipment/current';
  static const String drivercurrentShiping =
      '$baseUrl/api/v1/shipment/current?page=';
  static const String driverLoadRequest = '$baseUrl/api/v1/loads-request?page=';
  static const String shippingHistory = '$baseUrl/api/v1/shipment/history';
  static const String chagePassword = '$baseUrl/api/v1/auth/change-password';
  static const String equipment = '$baseUrl/api/v1/truck-details';
  static String userLoadRequest({bool? requestType}) =>
      '$baseUrl/api/v1/loads-request?myRequests=$requestType';
  static String getNotification = '$baseUrl/api/v1/notifications?page=';
  static String notificationStatus = '$baseUrl/api/v1/notifications/read/';
  static String loadsDetails = '$baseUrl/api/v1/loads/';
  static String pendingShipment = '$baseUrl/api/v1/shipment/pending?page=';
  static String serviceFeedback(String userId) =>
      '$baseUrl/api/v1/feedbacks/$userId';
  static String nearestLoad = '$baseUrl/api/v1/loads/nearest_loads';
}
