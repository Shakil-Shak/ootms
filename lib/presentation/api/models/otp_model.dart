class OtpModels {
  final String status;
  final String statusCode;
  final String message;
  final OtpData data;
  final List<dynamic> errors;

  OtpModels({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory OtpModels.fromJson(Map<String, dynamic> json) {
    return OtpModels(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: OtpData.fromJson(json['data']),
      errors: json['errors'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
      'errors': errors,
    };
  }
}

class OtpData {
  final String type;
  final String forgetPasswordToken;

  OtpData({
    required this.type,
    required this.forgetPasswordToken,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      type: json['type'],
      forgetPasswordToken: json['forgetPasswordToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'forgetPasswordToken': forgetPasswordToken,
    };
  }
}
