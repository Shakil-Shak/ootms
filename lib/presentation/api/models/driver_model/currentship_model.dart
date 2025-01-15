// class DriverCurrentshipModel {
//   String? id;
//   User? user;
//   Driver? driver;
//   String? sender;
//   Load? load;
//   Truck? truck;
//   String? status;
//   int? version;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   DriverCurrentshipModel({
//     this.id = '',
//     this.user,
//     this.driver,
//     this.sender = '',
//     this.load,
//     this.truck,
//     this.status = '',
//     this.version = 0,
//     this.createdAt,
//     this.updatedAt,
//   });

//   DriverCurrentshipModel.fromJson(Map<String, dynamic> json) {
//     id = json['_id'] ?? '';
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
//     sender = json['sender'] ?? '';
//     load = json['load'] != null ? Load.fromJson(json['load']) : null;
//     truck = json['truck'] != null ? Truck.fromJson(json['truck']) : null;
//     status = json['status'] ?? '';
//     version = json['__v'] ?? 0;
//     createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
//     updatedAt = json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['_id'] = id;
//     if (user != null) {
//       data['user'] = user!.toJson();
//     }
//     if (driver != null) {
//       data['driver'] = driver!.toJson();
//     }
//     data['sender'] = sender;
//     if (load != null) {
//       data['load'] = load!.toJson();
//     }
//     if (truck != null) {
//       data['truck'] = truck!.toJson();
//     }
//     data['status'] = status;
//     data['__v'] = version;
//     data['createdAt'] = createdAt?.toIso8601String();
//     data['updatedAt'] = updatedAt?.toIso8601String();
//     return data;
//   }
// }

// class User {
//   String? id;
//   String? fullName;
//   String? image;

//   User({
//     this.id = '',
//     this.fullName = '',
//     this.image = '',
//   });

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['_id'] ?? '';
//     fullName = json['fullName'] ?? '';
//     image = json['image'] ?? '';
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'fullName': fullName,
//       'image': image,
//     };
//   }
// }

// class Driver {
//   String? id;
//   String? fullName;
//   String? email;
//   String? image;
//   String? address;
//   String? phoneNumber;

//   Driver({
//     this.id = '',
//     this.fullName = '',
//     this.email = '',
//     this.image = '',
//     this.address = '',
//     this.phoneNumber = '',
//   });

//   Driver.fromJson(Map<String, dynamic> json) {
//     id = json['_id'] ?? '';
//     fullName = json['fullName'] ?? '';
//     email = json['email'] ?? '';
//     image = json['image'] ?? '';
//     address = json['address'] ?? '';
//     phoneNumber = json['phoneNumber'] ?? '';
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'fullName': fullName,
//       'email': email,
//       'image': image,
//       'address': address,
//       'phoneNumber': phoneNumber,
//     };
//   }
// }

// class Load {
//   String? id;
//   String? shipperName;
//   String? shipperPhoneNumber;
//   String? shipperEmail;
//   String? shippingAddress;
//   int? palletSpace;
//   int? weight;
//   String? loadType;
//   int? trailerSize;
//   List<String>? hazmat;
//   String? receiverName;
//   String? receiverPhoneNumber;
//   String? receiverEmail;
//   String? receivingAddress;
//   DateTime? pickupDate;
//   DateTime? deliveryDate;
//   String? deliveryInstruction;

//   Load({
//     this.id = '',
//     this.shipperName = '',
//     this.shipperPhoneNumber = '',
//     this.shipperEmail = '',
//     this.shippingAddress = '',
//     this.palletSpace = 0,
//     this.weight = 0,
//     this.loadType = '',
//     this.trailerSize = 0,
//     this.hazmat,
//     this.receiverName = '',
//     this.receiverPhoneNumber = '',
//     this.receiverEmail = '',
//     this.receivingAddress = '',
//     this.pickupDate,
//     this.deliveryDate,
//     this.deliveryInstruction = '',
//   });

//   Load.fromJson(Map<String, dynamic> json) {
//     id = json['_id'] ?? '';
//     shipperName = json['shipperName'] ?? '';
//     shipperPhoneNumber = json['shipperPhoneNumber'] ?? '';
//     shipperEmail = json['shipperEmail'] ?? '';
//     shippingAddress = json['shippingAddress'] ?? '';
//     palletSpace = json['palletSpace'] ?? 0;
//     weight = json['weight'] ?? 0;
//     loadType = json['loadType'] ?? '';
//     trailerSize = json['trailerSize'] ?? 0;
//     hazmat = json['Hazmat'] != null ? List<String>.from(json['Hazmat']) : [];
//     receiverName = json['receiverName'] ?? '';
//     receiverPhoneNumber = json['receiverPhoneNumber'] ?? '';
//     receiverEmail = json['receiverEmail'] ?? '';
//     receivingAddress = json['receivingAddress'] ?? '';
//     pickupDate = json['pickupDate'] != null ? DateTime.parse(json['pickupDate']) : null;
//     deliveryDate = json['deliveryDate'] != null ? DateTime.parse(json['deliveryDate']) : null;
//     deliveryInstruction = json['deliveryInstruction'] ?? '';
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'shipperName': shipperName,
//       'shipperPhoneNumber': shipperPhoneNumber,
//       'shipperEmail': shipperEmail,
//       'shippingAddress': shippingAddress,
//       'palletSpace': palletSpace,
//       'weight': weight,
//       'loadType': loadType,
//       'trailerSize': trailerSize,
//       'Hazmat': hazmat,
//       'receiverName': receiverName,
//       'receiverPhoneNumber': receiverPhoneNumber,
//       'receiverEmail': receiverEmail,
//       'receivingAddress': receivingAddress,
//       'pickupDate': pickupDate?.toIso8601String(),
//       'deliveryDate': deliveryDate?.toIso8601String(),
//       'deliveryInstruction': deliveryInstruction,
//     };
//   }
// }

// class Truck {
//   String? id;
//   String? truckNumber;
//   int? trailerSize;

//   Truck({
//     this.id = '',
//     this.truckNumber = '',
//     this.trailerSize = 0,
//   });

//   Truck.fromJson(Map<String, dynamic> json) {
//     id = json['_id'] ?? '';
//     truckNumber = json['truckNumber'] ?? '';
//     trailerSize = json['trailerSize'] ?? 0;
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'truckNumber': truckNumber,
//       'trailerSize': trailerSize,
//     };
//   }
// }

class DriverCurrentshipModel {
  String? id;
  User? user;
  Driver? driver;
  String? sender;
  Load? load;
  Truck? truck;
  String? status;
  int? version;
  DateTime? createdAt;
  DateTime? updatedAt;

  DriverCurrentshipModel({
    this.id = '',
    this.user,
    this.driver,
    this.sender = '',
    this.load,
    this.truck,
    this.status = '',
    this.version = 0,
    this.createdAt,
    this.updatedAt,
  });

  DriverCurrentshipModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    sender = json['sender'] ?? '';
    load = json['load'] != null ? Load.fromJson(json['load']) : null;
    truck = json['truck'] != null ? Truck.fromJson(json['truck']) : null;
    status = json['status'] ?? '';
    version = json['__v'] ?? 0;
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;
  }

  @override
  String toString() {
    return 'DriverCurrentshipModel(id: $id, sender: $sender, status: $status, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, driver: $driver, load: $load, truck: $truck)';
  }
}

class User {
  String? id;
  String? fullName;
  String? image;

  User({
    this.id = '',
    this.fullName = '',
    this.image = '',
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    fullName = json['fullName'] ?? '';
    image = json['image'] ?? '';
  }

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, image: $image)';
  }
}

class Driver {
  String? id;
  String? fullName;
  String? email;
  String? image;
  String? address;
  String? phoneNumber;

  Driver({
    this.id = '',
    this.fullName = '',
    this.email = '',
    this.image = '',
    this.address = '',
    this.phoneNumber = '',
  });

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    fullName = json['fullName'] ?? '';
    email = json['email'] ?? '';
    image = json['image'] ?? '';
    address = json['address'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
  }

  @override
  String toString() {
    return 'Driver(id: $id, fullName: $fullName, email: $email, address: $address, phoneNumber: $phoneNumber)';
  }
}

class Load {
  String? id;
  String? shipperName;
  String? shipperPhoneNumber;
  String? shipperEmail;
  String? shippingAddress;
  int? palletSpace;
  int? weight;
  String? loadType;
  int? trailerSize;
  List<String>? hazmat;
  String? receiverName;
  String? receiverPhoneNumber;
  String? receiverEmail;
  String? receivingAddress;
  DateTime? pickupDate;
  DateTime? deliveryDate;
  String? deliveryInstruction;

  Load({
    this.id = '',
    this.shipperName = '',
    this.shipperPhoneNumber = '',
    this.shipperEmail = '',
    this.shippingAddress = '',
    this.palletSpace = 0,
    this.weight = 0,
    this.loadType = '',
    this.trailerSize = 0,
    this.hazmat,
    this.receiverName = '',
    this.receiverPhoneNumber = '',
    this.receiverEmail = '',
    this.receivingAddress = '',
    this.pickupDate,
    this.deliveryDate,
    this.deliveryInstruction = '',
  });

  Load.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    shipperName = json['shipperName'] ?? '';
    shipperPhoneNumber = json['shipperPhoneNumber'] ?? '';
    shipperEmail = json['shipperEmail'] ?? '';
    shippingAddress = json['shippingAddress'] ?? '';
    palletSpace = json['palletSpace'] ?? 0;
    weight = json['weight'] ?? 0;
    loadType = json['loadType'] ?? '';
    trailerSize = json['trailerSize'] ?? 0;
    hazmat = json['Hazmat'] != null ? List<String>.from(json['Hazmat']) : [];
    receiverName = json['receiverName'] ?? '';
    receiverPhoneNumber = json['receiverPhoneNumber'] ?? '';
    receiverEmail = json['receiverEmail'] ?? '';
    receivingAddress = json['receivingAddress'] ?? '';
    pickupDate = json['pickupDate'] != null ? DateTime.parse(json['pickupDate']) : null;
    deliveryDate = json['deliveryDate'] != null ? DateTime.parse(json['deliveryDate']) : null;
    deliveryInstruction = json['deliveryInstruction'] ?? '';
  }

  @override
  String toString() {
    return 'Load(id: $id, shipperName: $shipperName, receiverName: $receiverName, loadType: $loadType, palletSpace: $palletSpace, weight: $weight)';
  }
}

class Truck {
  String? id;
  String? truckNumber;
  int? trailerSize;

  Truck({
    this.id = '',
    this.truckNumber = '',
    this.trailerSize = 0,
  });

  Truck.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    truckNumber = json['truckNumber'] ?? '';
    trailerSize = json['trailerSize'] ?? 0;
  }

  @override
  String toString() {
    return 'Truck(id: $id, truckNumber: $truckNumber, trailerSize: $trailerSize)';
  }
}
