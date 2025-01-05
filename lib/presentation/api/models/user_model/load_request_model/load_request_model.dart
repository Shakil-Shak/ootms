// class LoadRequestModel {
//   String? id;
//   User? user;
//   Driver? driver;
//   Sender? sender;
//   Load? load;
//   String status;
//   int version;
//   DateTime createdAt;
//   DateTime updatedAt;

//   LoadRequestModel({
//     this.id,
//     this.user,
//     this.driver,
//     this.sender,
//     this.load,
//     this.status = "Pending",
//     this.version = 0,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   })  : createdAt = createdAt ?? DateTime.now(),
//         updatedAt = updatedAt ?? DateTime.now();

//   factory LoadRequestModel.fromJson(Map<String, dynamic> json) {
//     return LoadRequestModel(
//       id: json['_id'],
//       user: json['user'] != null ? User.fromJson(json['user']) : null,
//       driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
//       sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
//       load: json['load'] != null ? Load.fromJson(json['load']) : null,
//       status: json['status'] ?? "Pending",
//       version: json['__v'] ?? 0,
//       createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
//       updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
//     );
//   }
// }

// class User {
//   String? id;

//   User({this.id});

//   factory User.fromJson(dynamic json) {
//     return User(
//       id: json,
//     );
//   }
// }

// class Driver {
//   String? id;
//   String fullName;
//   String email;
//   String image;
//   String address;
//   String phoneNumber;

//   Driver({
//     this.id,
//     this.fullName = "",
//     this.email = "",
//     this.image = "",
//     this.address = "",
//     this.phoneNumber = "",
//   });

//   factory Driver.fromJson(Map<String, dynamic> json) {
//     return Driver(
//       id: json['_id'],
//       fullName: json['fullName'] ?? "",
//       email: json['email'] ?? "",
//       image: json['image'] ?? "",
//       address: json['address'] ?? "",
//       phoneNumber: json['phoneNumber'] ?? "",
//     );
//   }

// }

// class Sender {
//   String? id;

//   Sender({this.id});

//   factory Sender.fromJson(dynamic json) {
//     return Sender(
//       id: json,
//     );
//   }
// }

// class Load {
//   String? id;
//   String shipperPhoneNumber;
//   String shipperEmail;
//   String shippingAddress;
//   String hazmat;
//   String receiverPhoneNumber;
//   String receiverEmail;
//   String receivingAddress;
//   int palletSpace;

//   Load({
//     this.id,
//     this.shipperPhoneNumber = "",
//     this.shipperEmail = "",
//     this.shippingAddress = "",
//     this.hazmat = "",
//     this.receiverPhoneNumber = "",
//     this.receiverEmail = "",
//     this.receivingAddress = "",
//     this.palletSpace = 0,
//   });

//   factory Load.fromJson(Map<String, dynamic> json) {
//     return Load(
//       id: json['_id'],
//       shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
//       shipperEmail: json['shipperEmail'] ?? "",
//       shippingAddress: json['shippingAddress'] ?? "",
//       hazmat: json['Hazmat'] ?? "",
//       receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
//       receiverEmail: json['receiverEmail'] ?? "",
//       receivingAddress: json['receivingAddress'] ?? "",
//       palletSpace: json['palletSpace'] ?? 0,
//     );
//   }
// }
class LoadRequestModel {
  Driver driver;
  Load load;
  Truck truck;
  int availablePalletSpace;

  LoadRequestModel({
    required this.driver,
    required this.load,
    required this.truck,
    required this.availablePalletSpace,
  });

  factory LoadRequestModel.fromJson(Map<String, dynamic> json) {
    return LoadRequestModel(
      driver: Driver.fromJson(json['driver'] ?? {}),
      load: Load.fromJson(json['load'] ?? {}),
      truck: Truck.fromJson(json['truck'] ?? {}),
      availablePalletSpace: json['availablePalletSpace'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driver': driver.toJson(),
      'load': load.toJson(),
      'truck': truck.toJson(),
      'availablePalletSpace': availablePalletSpace,
    };
  }

  factory LoadRequestModel.defaultValue() {
    return LoadRequestModel(
      driver: Driver.defaultValue(),
      load: Load.defaultValue(),
      truck: Truck.defaultValue(),
      availablePalletSpace: 0,
    );
  }
}

class Driver {
  String fullName;
  String email;
  String phoneNumber;
  String address;
  String image;

  Driver({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.image,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      fullName: json['fullName'] ?? 'Nasif Rahaman',
      email: json['email'] ?? 'kelaw98401@chansd.com',
      phoneNumber: json['phoneNumber'] ?? '01798552923',
      address: json['address'] ?? 'Dhaka',
      image: json['image'] ?? '/uploads/users/images-1735992334776.jpg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'image': image,
    };
  }

  factory Driver.defaultValue() {
    return Driver(
      fullName: 'Nasif Rahaman',
      email: 'kelaw98401@chansd.com',
      phoneNumber: '01798552923',
      address: 'Dhaka',
      image: '/uploads/users/images-1735992334776.jpg',
    );
  }
}

class Load {
  String loadType;
  int palletSpace;
  int trailerSize;
  DateTime pickupDate;
  DateTime deliveryDate;
  String hazmat;
  int weight;

  Load({
    required this.loadType,
    required this.palletSpace,
    required this.trailerSize,
    required this.pickupDate,
    required this.deliveryDate,
    required this.hazmat,
    required this.weight,
  });

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      loadType: json['loadType'] ?? 'Full Load',
      palletSpace: json['palletSpace'] ?? 10,
      trailerSize: json['trailerSize'] ?? 500,
      pickupDate: DateTime.parse(json['pickupDate'] ?? '2025-01-10T08:00:00.000Z'),
      deliveryDate: DateTime.parse(json['deliveryDate'] ?? '2025-01-12T18:00:00.000Z'),
      hazmat: json['Hazmat'] ?? 'Class 2',
      weight: json['weight'] ?? 1500,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loadType': loadType,
      'palletSpace': palletSpace,
      'trailerSize': trailerSize,
      'pickupDate': pickupDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'Hazmat': hazmat,
      'weight': weight,
    };
  }

  factory Load.defaultValue() {
    return Load(
      loadType: 'Full Load',
      palletSpace: 10,
      trailerSize: 500,
      pickupDate: DateTime.parse('2025-01-10T08:00:00.000Z'),
      deliveryDate: DateTime.parse('2025-01-12T18:00:00.000Z'),
      hazmat: 'Class 2',
      weight: 1500,
    );
  }
}

class Truck {
  String truckNumber;
  int trailerSize;
  int palletSpace;

  Truck({
    required this.truckNumber,
    required this.trailerSize,
    required this.palletSpace,
  });

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      truckNumber: json['truckNumber'] ?? 'TRK123456',
      trailerSize: json['trailerSize'] ?? 50,
      palletSpace: json['palletSpace'] ?? 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'truckNumber': truckNumber,
      'trailerSize': trailerSize,
      'palletSpace': palletSpace,
    };
  }

  factory Truck.defaultValue() {
    return Truck(
      truckNumber: 'TRK123456',
      trailerSize: 50,
      palletSpace: 10,
    );
  }
}
