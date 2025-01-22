// class ShippingHistoryModel {
//   String id;
//   String user;
//   DriverModel driver;
//   String sender;
//   LoadModel load;
//   String status;
//   int version;
//   DateTime createdAt;
//   DateTime updatedAt;

//   ShippingHistoryModel({
//     this.id = "",
//     this.user = "",
//     required this.driver,
//     this.sender = "",
//     required this.load,
//     this.status = "Pending",
//     this.version = 0,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory ShippingHistoryModel.fromJson(Map<String, dynamic> json) {
//     return ShippingHistoryModel(
//       id: json['_id'] ?? "",
//       user: json['user'] ?? "",
//       driver: DriverModel.fromJson(json['driver']),
//       sender: json['sender'] ?? "",
//       load: LoadModel.fromJson(json['load']),
//       status: json['status'] ?? "Pending",
//       version: json['__v'] ?? 0,
//       createdAt:
//           DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
//       updatedAt:
//           DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
//     );
//   }
// }

// class UserModel {
//   String id;
//   String fullName;
//   String email;
//   String image;
//   String address;
//   String phoneNumber;

//   UserModel({
//     this.id = "",
//     this.fullName = "",
//     this.email = "",
//     this.image = "",
//     this.address = "",
//     this.phoneNumber = "",
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['_id'] ?? "",
//       fullName: json['fullName'] ?? "",
//       email: json['email'] ?? "",
//       image: json['image'] ?? "",
//       address: json['address'] ?? "",
//       phoneNumber: json['phoneNumber'] ?? "",
//     );
//   }
// }

// class DriverModel {
//   String id;
//   String fullName;
//   String email;
//   String image;
//   String address;
//   String phoneNumber;

//   DriverModel({
//     this.id = "",
//     this.fullName = "",
//     this.email = "",
//     this.image = "",
//     this.address = "",
//     this.phoneNumber = "",
//   });

//   factory DriverModel.fromJson(Map<String, dynamic> json) {
//     return DriverModel(
//       id: json['_id'] ?? "",
//       fullName: json['fullName'] ?? "",
//       email: json['email'] ?? "",
//       image: json['image'] ?? "",
//       address: json['address'] ?? "",
//       phoneNumber: json['phoneNumber'] ?? "",
//     );
//   }
// }

// class LoadModel {
//   String id;
//   String shipperName;
//   String shipperPhoneNumber;
//   String shipperEmail;
//   String shippingAddress;
//   int palletSpace;
//   int weight;
//   String loadType;
//   int trailerSize;
//   String hazmat;
//   String receiverName;
//   String receiverPhoneNumber;
//   String receiverEmail;
//   String receivingAddress;
//   DateTime pickupDate;
//   DateTime deliveryDate;
//   String deliveryInstruction;

//   LoadModel({
//     this.id = "",
//     this.shipperName = "",
//     this.shipperPhoneNumber = "",
//     this.shipperEmail = "",
//     this.shippingAddress = "",
//     this.palletSpace = 0,
//     this.weight = 0,
//     this.loadType = "",
//     this.trailerSize = 0,
//     this.hazmat = "",
//     this.receiverName = "",
//     this.receiverPhoneNumber = "",
//     this.receiverEmail = "",
//     this.receivingAddress = "",
//     required this.pickupDate,
//     required this.deliveryDate,
//     this.deliveryInstruction = "",
//   });

//   factory LoadModel.fromJson(Map<String, dynamic> json) {
//     return LoadModel(
//       id: json['_id'] ?? "",
//       shipperName: json['shipperName'] ?? "",
//       shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
//       shipperEmail: json['shipperEmail'] ?? "",
//       shippingAddress: json['shippingAddress'] ?? "",
//       palletSpace: json['palletSpace'] ?? 0,
//       weight: json['weight'] ?? 0,
//       loadType: json['loadType'] ?? "",
//       trailerSize: json['trailerSize'] ?? 0,
//       hazmat: json['Hazmat'] ?? "",
//       receiverName: json['receiverName'] ?? "",
//       receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
//       receiverEmail: json['receiverEmail'] ?? "",
//       receivingAddress: json['receivingAddress'] ?? "",
//       pickupDate: DateTime.parse(
//           json['pickupDate'] ?? DateTime.now().toIso8601String()),
//       deliveryDate: DateTime.parse(
//           json['deliveryDate'] ?? DateTime.now().toIso8601String()),
//       deliveryInstruction: json['deliveryInstruction'] ?? "",
//     );
//   }
// }


import 'package:ootms/presentation/api/models/driver_model/load_request_model.dart';

class ShippingHistoryModel {
  String id;
  User user;
  DriverModel driver;
  String sender;
  String status;
  int version;
  DateTime createdAt;
  DateTime updatedAt;
  LoadModel load;

  ShippingHistoryModel({
    this.id = "",
    User? user,
    required this.driver,
    this.sender = "",
    this.status = "Pending",
    this.version = 0,
    required this.createdAt,
    required this.updatedAt,
    required this.load,
  }): user = user ?? User();

  factory ShippingHistoryModel.fromJson(Map<String, dynamic> json) {
    return ShippingHistoryModel(
      id: json['_id'] ?? "",
      user: User.fromJson(json['user'] ?? {}),
      driver: DriverModel.fromJson(json['driver'] ?? {}),
      sender: json['sender'] ?? "",
      status: json['status'] ?? "Pending",
      version: json['__v'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      load: LoadModel.fromJson(json['load'] ?? {}),
    );
  }
}
class DriverModel {
  String id;
  String fullName;
  String email;
  String image;
  String address;
  String phoneNumber;

  DriverModel({
    this.id = "",
    this.fullName = "",
    this.email = "",
    this.image = "",
    this.address = "",
    this.phoneNumber = "",
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['_id'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
      address: json['address'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
    );
  }
}
class LoadModel {
  String id;
  String shipperName;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  int palletSpace;
  int weight;
  String loadType;
  int trailerSize;
  List<String> hazmat; // Changed to List<String>
  String receiverName;
  String receiverPhoneNumber;
  String receiverEmail;
  String receivingAddress;
  DateTime pickupDate;
  DateTime deliveryDate;
  String deliveryInstruction;
  String bolNo;

  LoadModel({
    this.id = "",
    this.shipperName = "",
    this.shipperPhoneNumber = "",
    this.shipperEmail = "",
    this.shippingAddress = "",
    this.palletSpace = 0,
    this.weight = 0,
    this.loadType = "",
    this.trailerSize = 0,
    this.hazmat = const [], // Default to an empty list
    this.receiverName = "",
    this.receiverPhoneNumber = "",
    this.receiverEmail = "",
    this.receivingAddress = "",
    required this.pickupDate,
    required this.deliveryDate,
    this.deliveryInstruction = "",
    this.bolNo = "",
  });

  factory LoadModel.fromJson(Map<String, dynamic> json) {
    return LoadModel(
      id: json['_id'] ?? "",
      shipperName: json['shipperName'] ?? "",
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
      shipperEmail: json['shipperEmail'] ?? "",
      shippingAddress: json['shippingAddress'] ?? "",
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      loadType: json['loadType'] ?? "",
      trailerSize: json['trailerSize'] ?? 0,
      hazmat: (json['Hazmat'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [], // Parse as List<String>
      receiverName: json['receiverName'] ?? "",
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
      receiverEmail: json['receiverEmail'] ?? "",
      receivingAddress: json['receivingAddress'] ?? "",
      pickupDate: DateTime.parse(json['pickupDate'] ?? DateTime.now().toIso8601String()),
      deliveryDate: DateTime.parse(json['deliveryDate'] ?? DateTime.now().toIso8601String()),
      deliveryInstruction: json['deliveryInstruction'] ?? "",
      bolNo: json['bolNo'] ?? "",
    );
  }
}


