
class NearestDriverModel {
  String id;
  String userId;
  String fullName;
  String email;
  String image;
  String role;
  bool isOnDuty;
  bool isDeleted;
  bool validDriver;
  double ratings;
  DateTime createdAt;
  DateTime updatedAt;
  double distance;
  DriverLocation location;
  String document;
  bool isComplete;
  bool isSocialLogin;
  int remainingDispatch;
  String address;
  String phoneNumber;

  NearestDriverModel({
    this.id = "",
    this.userId = "",
    this.fullName = "",
    this.email = "",
    this.image = "",
    this.role = "",
    this.isOnDuty = false,
    this.isDeleted = false,
    this.validDriver = false,
    this.ratings = 0.0,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.distance = 0.0,
    DriverLocation? location,
    this.document = "",
    this.isComplete = false,
    this.isSocialLogin = false,
    this.remainingDispatch = 0,
    this.address = "",
    this.phoneNumber = "",
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        location = location ?? DriverLocation();

  factory NearestDriverModel.fromJson(Map<String, dynamic> json) {
    return NearestDriverModel(
      id: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
      role: json['role'] ?? "",
      isOnDuty: json['isOnDuty'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      validDriver: json['validDriver'] ?? false,
      ratings: (json['ratings'] ?? 0).toDouble(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      distance: (json['distance'] ?? 0).toDouble(),
      location: json['location'] != null ? DriverLocation.fromJson(json['location']) : null,
      document: json['document'] ?? "",
      isComplete: json['isComplete'] ?? false,
      isSocialLogin: json['isSocialLogin'] ?? false,
      remainingDispatch: json['remainingDispatch'] ?? 0,
      address: json['address'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
    );
  }
}

class DriverLocation {
  String type;
  List<double> coordinates;

  DriverLocation({
    this.type = "Point",
    List<double>? coordinates,
  }) : coordinates = coordinates ?? [];

  factory DriverLocation.fromJson(Map<String, dynamic> json) {
    return DriverLocation(
      type: json['type'] ?? "Point",
      coordinates: (json['coordinates'] as List?)?.map((e) => (e as num).toDouble()).toList() ?? [],
    );
  }
}

class LoadLocationModel {
  String type;
  List<double> coordinates;

  LoadLocationModel({
    this.type = "",
    List<double>? coordinates,
  }) : coordinates = coordinates ?? [];

  factory LoadLocationModel.fromJson(Map<String, dynamic> json) {
    return LoadLocationModel(
      type: json['type'] ?? "",
      coordinates: List<double>.from(json['coordinates'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
