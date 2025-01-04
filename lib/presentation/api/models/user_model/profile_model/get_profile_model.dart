
class ProfileModel {
  String? id;
  String? userId;
  String? fullName;
  String? email;
  String? image;
  String? password;
  bool isOnDuty;
  int ratings;
  int dispatchCompleted;
  String? role;
  String? createdAt;
  String? updatedAt;
  int version;
  String? address;
  String? phoneNumber;

  ProfileModel({
    this.id,
    this.userId,
    this.fullName = "Unknown",
    this.email = "",
    this.image = "",
    this.password = "",
    this.isOnDuty = false,
    this.ratings = 0,
    this.dispatchCompleted = 0,
    this.role = "user",
    this.createdAt,
    this.updatedAt,
    this.version = 0,
    this.address = "Not provided",
    this.phoneNumber = "0000000000",
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      userId: json['userId'],
      fullName: json['fullName'],
      email: json['email'],
      image: json['image'],
      password: json['password'],
      isOnDuty: json['isOnDuty'] ?? false,
      ratings: json['ratings'] ?? 0,
      dispatchCompleted: json['dispatchCompleted'] ?? 0,
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'] ?? 0,
      address: json['address'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userId": userId,
      "fullName": fullName,
      "email": email,
      "image": image,
      "password": password,
      "isOnDuty": isOnDuty,
      "ratings": ratings,
      "dispatchCompleted": dispatchCompleted,
      "role": role,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": version,
      "address": address,
      "phoneNumber": phoneNumber,
    };
  }

  @override
  String toString() {
    return '''
ProfileModel {
  id: $id,
  userId: $userId,
  fullName: $fullName,
  email: $email,
  image: $image,
  isOnDuty: $isOnDuty,
  ratings: $ratings,
  dispatchCompleted: $dispatchCompleted,
  role: $role,
  address: $address,
  phoneNumber: $phoneNumber
}
''';
  }
}
