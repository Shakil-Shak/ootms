class ExceptionModel {
  final String status;
  final int statusCode;
  final String message;
  final ErrorData data;
  final List<dynamic> errors;

  ExceptionModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory ExceptionModel.fromJson(Map<String, dynamic> json) {
    return ExceptionModel(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: ErrorData.fromJson(json['data']),
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

class ErrorData {
  final String type;

  ErrorData({
    required this.type,
  });

  factory ErrorData.fromJson(Map<String, dynamic> json) {
    return ErrorData(
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}
