
class PreferredDriverModel {
  String? id;
  String? user;
  DriverInfo? driverInfo;

  PreferredDriverModel({
    this.id,
    this.user,
    this.driverInfo,
  });

  factory PreferredDriverModel.fromJson(Map<String, dynamic> json) {
    return PreferredDriverModel(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      driverInfo: json['driverInfo'] != null
          ? DriverInfo.fromJson(json['driverInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id ?? '',
      'user': user ?? '',
      'driverInfo': driverInfo?.toJson(),
    };
  }
}

class DriverInfo {
  String? id;
  String? userId;
  String? fullName;
  String? email;
  String? image;
  String? document;
  String? password;
  bool? isOnDuty;
  bool? isComplete;
  bool? validDriver;
  bool? isSocialLogin;
  bool? isDeleted;
  int? ratings;
  int? remainingDispatch;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  Location? location;

  DriverInfo({
    this.id,
    this.userId,
    this.fullName,
    this.email,
    this.image,
    this.document,
    this.password,
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = true,
    this.isSocialLogin = false,
    this.isDeleted = false,
    this.ratings = 0,
    this.remainingDispatch = 0,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.location,
  });

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
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id ?? '',
      'userId': userId ?? '',
      'fullName': fullName ?? '',
      'email': email ?? '',
      'image': image ?? '',
      'document': document ?? '',
      'password': password ?? '',
      'isOnDuty': isOnDuty ?? false,
      'isComplete': isComplete ?? false,
      'validDriver': validDriver ?? true,
      'isSocialLogin': isSocialLogin ?? false,
      'isDeleted': isDeleted ?? false,
      'ratings': ratings ?? 0,
      'remainingDispatch': remainingDispatch ?? 0,
      'role': role ?? '',
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'location': location?.toJson(),
    };
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

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
      'type': type ?? '',
      'coordinates': coordinates ?? [],
    };
  }
}
