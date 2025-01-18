class ProfileModel {
  final String document;
  final String id;
  final String userId;
  final String fullName;
  final String email;
  final String image;
  final bool isOnDuty;
  final int ratings;
  final int dispatchCompleted;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String address;
  final bool isComplete;
  final String phoneNumber;
  final bool validDriver;
  final bool isDeleted;
  final int remainingDispatch;

  ProfileModel({
    this.document = "",
    this.id = "",
    this.userId = "",
    this.fullName = "",
    this.email = "",
    this.image = "",
    this.isOnDuty = false,
    this.ratings = 0,
    this.dispatchCompleted = 0,
    this.role = "",
    DateTime? createdAt,
    DateTime? updatedAt,
    this.address = "",
    this.isComplete = false,
    this.phoneNumber = "",
    this.validDriver = false,
    this.isDeleted = false,
    this.remainingDispatch = 0,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      document: json['document'] ?? "",
      id: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
      isOnDuty: json['isOnDuty'] ?? false,
      ratings: json['ratings'] ?? 0,
      dispatchCompleted: json['dispatchCompleted'] ?? 0,
      role: json['role'] ?? "",
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      address: json['address'] ?? "",
      isComplete: json['isComplete'] ?? false,
      phoneNumber: json['phoneNumber'] ?? "",
      validDriver: json['validDriver'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      remainingDispatch: json['remainingDispatch'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document': document,
      '_id': id,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'image': image,
      'isOnDuty': isOnDuty,
      'ratings': ratings,
      'dispatchCompleted': dispatchCompleted,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'address': address,
      'isComplete': isComplete,
      'phoneNumber': phoneNumber,
      'validDriver': validDriver,
      'isDeleted': isDeleted,
      'remainingDispatch': remainingDispatch,
    };
  }
}
