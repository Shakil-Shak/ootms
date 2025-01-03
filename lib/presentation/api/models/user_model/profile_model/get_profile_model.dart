class ProfileModel {
  String id;
  String userId;
  String fullName;
  String email;
  String image;
  String password;
  bool isOnDuty;
  int ratings;
  int dispatchCompleted;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  ProfileModel({
    this.id = "",
    this.userId = "",
    this.fullName = "",
    this.email = "",
    this.image = "",
    this.password = "",
    this.isOnDuty = false,
    this.ratings = 0,
    this.dispatchCompleted = 0,
    this.role = "",
    DateTime? createdAt,
    DateTime? updatedAt,
    this.version = 0,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Factory constructor to create an instance from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
      password: json['password'] ?? "",
      isOnDuty: json['isOnDuty'] ?? false,
      ratings: json['ratings'] ?? 0,
      dispatchCompleted: json['dispatchCompleted'] ?? 0,
      role: json['role'] ?? "",
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
      version: json['__v'] ?? 0,
    );
  }

  // Method to convert the model to JSON
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  // Override toString for a readable string representation
  @override
  String toString() {
    return 'ProfileModel(id: $id, userId: $userId, fullName: $fullName, email: $email, '
        'image: $image, isOnDuty: $isOnDuty, ratings: $ratings, dispatchCompleted: $dispatchCompleted, '
        'role: $role, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
  }
}
