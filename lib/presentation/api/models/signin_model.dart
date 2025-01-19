class SignInModel {
  String status;
  String statusCode;
  String message;
  SignInData data;
  List<dynamic> errors;

  SignInModel({
    this.status = "",
    this.statusCode = "",
    this.message = "",
    SignInData? data,
    this.errors = const [],
  }) : data = data ?? SignInData();

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      status: json["status"] ?? "",
      statusCode: json["statusCode"] ?? "",
      message: json["message"] ?? "",
      data: json["data"] != null ? SignInData.fromJson(json["data"]) : SignInData(),
      errors: json["errors"] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "statusCode": statusCode,
      "message": message,
      "data": data.toJson(),
      "errors": errors,
    };
  }
}

class SignInData {
  String type;
  SignInAttributes attributes;
  String accessToken;

  SignInData({
    this.type = "",
    SignInAttributes? attributes,
    this.accessToken = "",
  }) : attributes = attributes ?? SignInAttributes();

  factory SignInData.fromJson(Map<String, dynamic> json) {
    return SignInData(
      type: json["type"] ?? "",
      attributes: json["attributes"] != null
          ? SignInAttributes.fromJson(json["attributes"])
          : SignInAttributes(),
      accessToken: json["accessToken"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "attributes": attributes.toJson(),
      "accessToken": accessToken,
    };
  }
}

class SignInAttributes {
  bool isSocialLogin;
  String id;
  String userId;
  String fullName;
  String email;
  String password;
  bool isOnDuty;
  bool isComplete;
  bool validDriver;
  bool isDeleted;
  double ratings;
  num remainingDispatch;
  String role;
  String createdAt;
  String updatedAt;
  num version;
  String address;
  String document;
  String image;
  String phoneNumber;

  SignInAttributes({
    this.isSocialLogin = false,
    this.id = "",
    this.userId = "",
    this.fullName = "",
    this.email = "",
    this.password = "",
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = false,
    this.isDeleted = false,
    this.ratings = 0.0,
    this.remainingDispatch = 0,
    this.role = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.version = 0,
    this.address = "",
    this.document = "",
    this.image = "",
    this.phoneNumber = "",
  });

  factory SignInAttributes.fromJson(Map<String, dynamic> json) {
    return SignInAttributes(
      isSocialLogin: json["isSocialLogin"] ?? false,
      id: json["_id"] ?? "",
      userId: json["userId"] ?? "",
      fullName: json["fullName"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      isOnDuty: json["isOnDuty"] ?? false,
      isComplete: json["isComplete"] ?? false,
      validDriver: json["validDriver"] ?? false,
      isDeleted: json["isDeleted"] ?? false,
      ratings: (json["ratings"] ?? 0).toDouble(),
      remainingDispatch: json["remainingDispatch"] ?? 0,
      role: json["role"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      version: json["__v"] ?? 0,
      address: json["address"] ?? "",
      document: json["document"] ?? "",
      image: json["image"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isSocialLogin": isSocialLogin,
      "_id": id,
      "userId": userId,
      "fullName": fullName,
      "email": email,
      "password": password,
      "isOnDuty": isOnDuty,
      "isComplete": isComplete,
      "validDriver": validDriver,
      "isDeleted": isDeleted,
      "ratings": ratings,
      "remainingDispatch": remainingDispatch,
      "role": role,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": version,
      "address": address,
      "document": document,
      "image": image,
      "phoneNumber": phoneNumber,
    };
  }
}

