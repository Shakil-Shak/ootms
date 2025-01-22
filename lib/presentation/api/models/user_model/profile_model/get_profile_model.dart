
import 'dart:convert';

class ProfileModel {
  String id;
  String userId;
  String fullName;
  String email;
  String image;
  String password;
  String phoneNumber;
  String address;
  String phoneCode;
  String googleId;
  String facebookId;
  DateTime birthday;
  bool isOnDuty;
  bool isComplete;
  bool validDriver;
  String cdlNumberImage;
  bool isSocialLogin;
  String taxid;
  bool isDeleted;
  int ratings;
  int remainingDispatch;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  int version;
  DriverLocation location;

  ProfileModel({
    this.id = '',
    this.userId = '',
    this.fullName = '',
    this.email = '',
    this.image = '/uploads/users/user.jpg',
    this.password = '',
    this.phoneNumber = '',
    this.address = '',
    this.phoneCode = '',
    this.googleId = '',
    this.facebookId = '',
    DateTime? birthday,
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = false,
    this.cdlNumberImage = '',
    this.isSocialLogin = false,
    this.taxid = '',
    this.isDeleted = false,
    this.ratings = 0,
    this.remainingDispatch = 0,
    this.role = 'user',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.version = 0,
    DriverLocation? location,
  })  : birthday = birthday ?? DateTime(1970, 1, 1),
        createdAt = createdAt ?? DateTime(1970, 1, 1),
        updatedAt = updatedAt ?? DateTime(1970, 1, 1),
        location = location ?? DriverLocation();

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '/uploads/users/user.jpg',
      password: json['password'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      phoneCode: json['phoneCode'] ?? '',
      googleId: json['googleId'] ?? '',
      facebookId: json['facebookId'] ?? '',
      birthday: json['birthday'] != null ? DateTime.parse(json['birthday']) : DateTime(1970, 1, 1),
      isOnDuty: json['isOnDuty'] ?? false,
      isComplete: json['isComplete'] ?? false,
      validDriver: json['validDriver'] ?? false,
      cdlNumberImage: json['cdlNumberImage'] ?? '',
      isSocialLogin: json['isSocialLogin'] ?? false,
      taxid: json['taxid'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      ratings: json['ratings'] ?? 0,
      remainingDispatch: json['remainingDispatch'] ?? 0,
      role: json['role'] ?? 'user',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime(1970, 1, 1),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime(1970, 1, 1),
      version: json['__v'] ?? 0,
      location: DriverLocation.fromJson(json['location'] ?? {}),
    );
  }

}

class DriverLocation {
  String type;
  List<double> coordinates;

  DriverLocation({
    this.type = 'Point',
    this.coordinates = const [0.0, 0.0],
  });

  factory DriverLocation.fromJson(Map<String, dynamic> json) {
    return DriverLocation(
      type: json['type'] ?? 'Point',
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
          [0.0, 0.0],
    );
  }
}
