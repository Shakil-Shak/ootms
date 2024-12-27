class SignInModel {
  final String status;
  final String statusCode;
  final String message;
  final SignInData data;
  final List<dynamic> errors;

  SignInModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: SignInData.fromJson(json['data']),
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

class SignInData {
  final String type;
  final Attributes attributes;
  final String accessToken;

  SignInData({
    required this.type,
    required this.attributes,
    required this.accessToken,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) {
    return SignInData(
      type: json['type'],
      attributes: Attributes.fromJson(json['attributes']),
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'attributes': attributes.toJson(),
      'accessToken': accessToken,
    };
  }
}

class Attributes {
  final String id;
  final String userId;
  final String fullName;
  final String email;
  final String image;
  final String password;
  final bool isOnDuty;
  final int ratings;
  final int dispatchCompleted;
  final String role;
  final String createdAt;
  final String updatedAt;
  final int version;

  Attributes({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.image,
    required this.password,
    required this.isOnDuty,
    required this.ratings,
    required this.dispatchCompleted,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      id: json['_id'],
      userId: json['userId'],
      fullName: json['fullName'],
      email: json['email'],
      image: json['image'],
      password: json['password'],
      isOnDuty: json['isOnDuty'],
      ratings: json['ratings'],
      dispatchCompleted: json['dispatchCompleted'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'image': image,
      'password': password,
      'isOnDuty': isOnDuty,
      'ratings': ratings,
      'dispatchCompleted': dispatchCompleted,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}
