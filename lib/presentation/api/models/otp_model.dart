class UserRegistrationResponse {
  String? status;
  String? statusCode;
  String? message;
  Data? data;
  List<dynamic>? errors;

  UserRegistrationResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.errors,
  });

  factory UserRegistrationResponse.fromJson(Map<String, dynamic> json) {
    return UserRegistrationResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      errors: json['errors'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data?.toJson(),
      'errors': errors,
    };
  }
}

class Data {
  String? type;
  Attributes? attributes;
  String? accessToken;

  Data({
    this.type,
    this.attributes,
    this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      type: json['type'],
      attributes: json['attributes'] != null
          ? Attributes.fromJson(json['attributes'])
          : null,
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'attributes': attributes?.toJson(),
      'accessToken': accessToken,
    };
  }
}

class Attributes {
  String? userId;
  String? fullName;
  String? email;
  String? image;
  String? password;
  bool? isOnDuty;
  int? ratings;
  int? dispatchCompleted;
  String? role;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Attributes({
    this.userId,
    this.fullName,
    this.email,
    this.image,
    this.password,
    this.isOnDuty,
    this.ratings,
    this.dispatchCompleted,
    this.role,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      userId: json['userId'],
      fullName: json['fullName'],
      email: json['email'],
      image: json['image'],
      password: json['password'],
      isOnDuty: json['isOnDuty'],
      ratings: json['ratings'],
      dispatchCompleted: json['dispatchCompleted'],
      role: json['role'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'image': image,
      'password': password,
      'isOnDuty': isOnDuty,
      'ratings': ratings,
      'dispatchCompleted': dispatchCompleted,
      'role': role,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
