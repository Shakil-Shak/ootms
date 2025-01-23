
class ProfileModel {
  final String id;
  final String userId;
  final String fullName;
  final String email;
  final bool isOnDuty;
  final bool isComplete;
  final bool validDriver;
  final bool isSocialLogin;
  final bool isDeleted;
  final double ratings;
  final int remainingDispatch;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String address;
  final String phoneNumber;
  final String taxid;
  final String image;

  ProfileModel({
    this.id = '',
    this.userId = '',
    this.fullName = '',
    this.email = '',
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = false,
    this.isSocialLogin = false,
    this.isDeleted = false,
    this.ratings = 0.0,
    this.remainingDispatch = 0,
    this.role = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.address = '',
    this.phoneNumber = '',
    this.taxid = '',
    this.image = '',
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      isOnDuty: json['isOnDuty'] ?? false,
      isComplete: json['isComplete'] ?? false,
      validDriver: json['validDriver'] ?? false,
      isSocialLogin: json['isSocialLogin'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      ratings: (json['ratings'] ?? 0).toDouble(),
      remainingDispatch: json['remainingDispatch'] ?? 0,
      role: json['role'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      taxid: json['taxid'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'isOnDuty': isOnDuty,
      'isComplete': isComplete,
      'validDriver': validDriver,
      'isSocialLogin': isSocialLogin,
      'isDeleted': isDeleted,
      'ratings': ratings,
      'remainingDispatch': remainingDispatch,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'address': address,
      'phoneNumber': phoneNumber,
      'taxid': taxid,
      'image': image,
    };
  }
}
