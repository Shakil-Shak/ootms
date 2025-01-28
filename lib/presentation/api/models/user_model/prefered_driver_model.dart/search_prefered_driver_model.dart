

class SearchPreferredDriverModel {
  String id;
  String userId;
  String fullName;
  String email;
  String password;
  bool isOnDuty;
  bool isComplete;
  bool validDriver;
  bool isSocialLogin;
  bool isDeleted;
  int ratings;
  String role;
  String createdAt;
  String updatedAt;
  String address;
  String cdlNumberImage;
  String phoneNumber;
  Location location;
  String image;

  SearchPreferredDriverModel({
    this.id = '',
    this.userId = '',
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = false,
    this.isSocialLogin = false,
    this.isDeleted = false,
    this.ratings = 0,
    this.role = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.address = '',
    this.cdlNumberImage = '',
    this.phoneNumber = '',
    this.image = '',
    Location? location,
  }) : location = location ?? Location();

  factory SearchPreferredDriverModel.fromJson(Map<String, dynamic> json) {
    return SearchPreferredDriverModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      isOnDuty: json['isOnDuty'] ?? false,
      isComplete: json['isComplete'] ?? false,
      validDriver: json['validDriver'] ?? false,
      isSocialLogin: json['isSocialLogin'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      ratings: json['ratings'] ?? 0,
      role: json['role'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      address: json['address'] ?? '',
      cdlNumberImage: json['cdlNumberImage'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : Location(),
    );
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
          ? List<double>.from(json['coordinates'].map((e) => e.toDouble()))
          : [],
    );
  }
}
