class PreferredDriverModel {
  String id;
  String user;
  DriverInfo driverInfo;

  PreferredDriverModel({
    this.id = '',
    this.user = '',
    DriverInfo? driverInfo,
  }) : driverInfo = driverInfo ?? DriverInfo();

  factory PreferredDriverModel.fromJson(Map<String, dynamic> json) {
    return PreferredDriverModel(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      driverInfo: json['driverInfo'] != null
          ? DriverInfo.fromJson(json['driverInfo'])
          : DriverInfo(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'driverInfo': driverInfo.toJson(),
    };
  }
}

class DriverInfo {
  String id;
  String userId;
  String fullName;
  String email;
  String image;
  String document;
  String password;
  bool isOnDuty;
  bool isComplete;
  bool validDriver;
  bool isSocialLogin;
  bool isDeleted;
  int ratings;
  int remainingDispatch;
  String role;
  String createdAt;
  String updatedAt;
  Location location;

  DriverInfo({
    this.id = '',
    this.userId = '',
    this.fullName = '',
    this.email = '',
    this.image = '',
    this.document = '',
    this.password = '',
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = true,
    this.isSocialLogin = false,
    this.isDeleted = false,
    this.ratings = 0,
    this.remainingDispatch = 0,
    this.role = '',
    this.createdAt = '',
    this.updatedAt = '',
    Location? location,
  }) : location = location ?? Location();

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      document: json['document'] ?? '',
      password: json['password'] ?? '',
      isOnDuty: json['isOnDuty'] ?? false,
      isComplete: json['isComplete'] ?? false,
      validDriver: json['validDriver'] ?? true,
      isSocialLogin: json['isSocialLogin'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      ratings: json['ratings'] ?? 0,
      remainingDispatch: json['remainingDispatch'] ?? 0,
      role: json['role'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : Location(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'image': image,
      'document': document,
      'password': password,
      'isOnDuty': isOnDuty,
      'isComplete': isComplete,
      'validDriver': validDriver,
      'isSocialLogin': isSocialLogin,
      'isDeleted': isDeleted,
      'ratings': ratings,
      'remainingDispatch': remainingDispatch,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'location': location.toJson(),
    };
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({
    this.type = '',
    List<double>? coordinates,
  }) : coordinates = coordinates ?? [];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
