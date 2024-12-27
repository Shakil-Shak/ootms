class SignUpResponseModel {
  final String status;
  final String statusCode;
  final String message;
  final SignUpData data;
  final List<dynamic> errors;

  SignUpResponseModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: SignUpData.fromJson(json['data']),
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

class SignUpData {
  final String type;
  final String signUpToken;

  SignUpData({
    required this.type,
    required this.signUpToken,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      type: json['type'],
      signUpToken: json['signUpToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'signUpToken': signUpToken,
    };
  }
}
