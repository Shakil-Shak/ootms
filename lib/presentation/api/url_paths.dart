class ApiPaths {
  static const String baseUrl = 'http://10.0.70.87:8020';
  // static const String baseUrl = 'http://10.0.70.112:8020';
  static const String socketUrl = 'http://10.0.70.87:3010';
  // static const String socketUrl = 'http://10.0.70.112:3010';

  static const String signinUrl = '$baseUrl/api/v1/auth/local';
  static const String socialSigninUrl = '$baseUrl/api/v1/auth/social_login';
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
  static const String preferredDriver = '$baseUrl/api/v1/loads-request';
  static const String userSupport = '$baseUrl/api/v1/support/';
  static const String shipingHistory = '$baseUrl/api/v1/shipment/history';
  static String staticContent({contentType}) =>
      '$baseUrl/api/v1/static-contents?type=$contentType';
  static const String currentShiping = '$baseUrl/api/v1/shipment/current';
  static const String drivercurrentShiping =
      '$baseUrl/api/v1/shipment/current?page=';
  static const String driverLoadRequest = '$baseUrl/api/v1/loads-request?myRequests=false&limit=10000000';
  static const String shippingHistory = '$baseUrl/api/v1/shipment/history';
  static const String chagePassword = '$baseUrl/api/v1/auth/change-password';
  static const String equipment = '$baseUrl/api/v1/equipment/';
  static const String addEquipment = '$baseUrl/api/v1/equipment/';
  static String userLoadRequest({bool? requestType}) =>
      '$baseUrl/api/v1/loads-request?myRequests=$requestType';
  static String getNotification = '$baseUrl/api/v1/notifications?page=';
  static String notificationStatus = '$baseUrl/api/v1/notifications/read/';
  static String loadsDetails = '$baseUrl/api/v1/loads/';
  static String pendingShipment = '$baseUrl/api/v1/loads/pending_shipment?page=';
  static String nearestLoad = '$baseUrl/api/v1/loads/nearest_loads';
  static String loadRequsetAction = '$baseUrl/api/v1/loads-request/action';
  static String serviceFeedback(String userId) =>
      '$baseUrl/api/v1/feedbacks/$userId';
  static String appFeedback = '$baseUrl/api/v1/feedbacks/';
  static String nearestDriver = '$baseUrl/api/v1/loads/get_nearest_driver?lastLoadId=';
  static String getPreferedDriver(String?search) => '$baseUrl/api/v1/preferred-driver?searchQuery=$search&limit=100000';
  static const String assignDriver = '$baseUrl/api/v1/loads-request';
  static const String findByBOL = '$baseUrl/api/v1/loads/find_by_billOfLading?bolNumber=';
  static const String onDuity = '$baseUrl/api/v1/users/switch_on_duty';
  static const String loadRequestFromDriver = '$baseUrl/api/v1/loads-request';
  static const String chatUrl = '$baseUrl/api/v1/messages/';

}
