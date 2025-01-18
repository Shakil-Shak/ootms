
// class LoadRequestModel {
//   Driver driver;
//   Load load;
//   Truck truck;
//   int availablePalletSpace;
//   bool isLoading = false;
//   bool isReject = false;
//   bool isAccept= false;

//   LoadRequestModel({
//     required this.driver,
//     required this.load,
//     required this.truck,
//     required this.availablePalletSpace,
//   });

//   factory LoadRequestModel.fromJson(Map<String, dynamic> json) {
//     return LoadRequestModel(
//       driver: Driver.fromJson(json['driver'] ?? {}),
//       load: Load.fromJson(json['load'] ?? {}),
//       truck: Truck.fromJson(json['truck'] ?? {}),
//       availablePalletSpace: json['availablePalletSpace'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'driver': driver.toJson(),
//       'load': load.toJson(),
//       'truck': truck.toJson(),
//       'availablePalletSpace': availablePalletSpace,
//     };
//   }

//   factory LoadRequestModel.defaultValue() {
//     return LoadRequestModel(
//       driver: Driver.defaultValue(),
//       load: Load.defaultValue(),
//       truck: Truck.defaultValue(),
//       availablePalletSpace: 0,
//     );
//   }
// }

// class Driver {
//   String fullName;
//   String email;
//   String phoneNumber;
//   String address;
//   String image;

//   Driver({
//     required this.fullName,
//     required this.email,
//     required this.phoneNumber,
//     required this.address,
//     required this.image,
//   });

//   factory Driver.fromJson(Map<String, dynamic> json) {
//     return Driver(
//       fullName: json['fullName'] ?? 'Nasif Rahaman',
//       email: json['email'] ?? 'kelaw98401@chansd.com',
//       phoneNumber: json['phoneNumber'] ?? '01798552923',
//       address: json['address'] ?? 'Dhaka',
//       image: json['image'] ?? '/uploads/users/images-1735992334776.jpg',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'fullName': fullName,
//       'email': email,
//       'phoneNumber': phoneNumber,
//       'address': address,
//       'image': image,
//     };
//   }

//   factory Driver.defaultValue() {
//     return Driver(
//       fullName: 'Nasif Rahaman',
//       email: 'kelaw98401@chansd.com',
//       phoneNumber: '01798552923',
//       address: 'Dhaka',
//       image: '/uploads/users/images-1735992334776.jpg',
//     );
//   }
// }

// class Load {
//   String loadType;
//   int palletSpace;
//   int trailerSize;
//   DateTime pickupDate;
//   String receivingAddress;
//   String shippingAddress;
//   DateTime deliveryDate;
//   List hazmat;
//   int weight;

//   Load({
//     required this.loadType,
//     required this.palletSpace,
//     required this.trailerSize,
//     required this.pickupDate,
//     required this.receivingAddress,
//     required this.shippingAddress,
//     required this.deliveryDate,
//     required this.hazmat,
//     required this.weight,
//   });

//   factory Load.fromJson(Map<String, dynamic> json) {
//     return Load(
//       loadType: json['loadType'] ?? 'Full Load',
//       palletSpace: json['palletSpace'] ?? 10,
//       trailerSize: json['trailerSize'] ?? 500,
//       pickupDate: DateTime.parse(json['pickupDate'] ?? '2025-01-10T08:00:00.000Z'),
//       receivingAddress: json['receivingAddress'] ?? "",
//       shippingAddress: json['shippingAddress'] ?? "",
//       deliveryDate: DateTime.parse(json['deliveryDate'] ?? '2025-01-12T18:00:00.000Z'),
//       hazmat: json['Hazmat'] != null
//           ? List<String>.from(json['Hazmat'])
//           : [],
//       weight: json['weight'] ?? 1500,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'loadType': loadType,
//       'palletSpace': palletSpace,
//       'trailerSize': trailerSize,
//       'pickupDate': pickupDate.toIso8601String(),
//       'deliveryDate': deliveryDate.toIso8601String(),
//       'Hazmat': hazmat,
//       'weight': weight,
//     };
//   }

//   factory Load.defaultValue() {
//     return Load(
//       loadType: 'Full Load',
//       palletSpace: 10,
//       trailerSize: 500,
//       pickupDate: DateTime.parse('2025-01-10T08:00:00.000Z'),
//       receivingAddress: "Receiver address not found",
//       shippingAddress: "Shipper address not found",
//       deliveryDate: DateTime.parse('2025-01-12T18:00:00.000Z'),
//       hazmat: [],
//       weight: 1500,
//     );
//   }
// }

// class Truck {
//   String truckNumber;
//   int trailerSize;
//   int palletSpace;

//   Truck({
//     required this.truckNumber,
//     required this.trailerSize,
//     required this.palletSpace,
//   });

//   factory Truck.fromJson(Map<String, dynamic> json) {
//     return Truck(
//       truckNumber: json['truckNumber'] ?? 'TRK123456',
//       trailerSize: json['trailerSize'] ?? 50,
//       palletSpace: json['palletSpace'] ?? 10,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'truckNumber': truckNumber,
//       'trailerSize': trailerSize,
//       'palletSpace': palletSpace,
//     };
//   }

//   factory Truck.defaultValue() {
//     return Truck(
//       truckNumber: 'TRK123456',
//       trailerSize: 50,
//       palletSpace: 10,
//     );
//   }
// }


class LoadRequestModel {
  final String id;
  final String status;
  final User user;
  final Driver driver;
  final Load load;
  final Truck truck;
  final int availablePalletSpace;
  
  bool isLoading = false;
  bool isReject = false;
  bool isAccept= false;

  LoadRequestModel({
    this.id = "",
    this.status = "Pending",
    User? user,
    Driver? driver,
    Load? load,
    Truck? truck,
    this.availablePalletSpace = 0,
  })  : user = user ?? User(),
        driver = driver ?? Driver(),
        load = load ?? Load(),
        truck = truck ?? Truck();

  factory LoadRequestModel.fromJson(Map<String, dynamic> json) {
    return LoadRequestModel(
      id: json['id'] ?? "",
      status: json['status'] ?? "Pending",
      user: json['user'] != null ? User.fromJson(json['user']) : User(),
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : Driver(),
      load: json['load'] != null ? Load.fromJson(json['load']) : Load(),
      truck: json['truck'] != null ? Truck.fromJson(json['truck']) : Truck(),
      availablePalletSpace: json['availablePalletSpace'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'user': user.toJson(),
      'driver': driver.toJson(),
      'load': load.toJson(),
      'truck': truck.toJson(),
      'availablePalletSpace': availablePalletSpace,
    };
  }
}

class User {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String image;

  User({
    this.fullName = "",
    this.email = "",
    this.phoneNumber = "",
    this.address = "",
    this.image = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      address: json['address'] ?? "",
      image: json['image'] ?? "",
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
}

class Driver extends User {
  Driver({
    String fullName = "",
    String email = "",
    String phoneNumber = "",
    String address = "",
    String image = "",
  }) : super(
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
          image: image,
        );

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      address: json['address'] ?? "",
      image: json['image'] ?? "",
    );
  }
}

class Load {
  final String loadType;
  final int palletSpace;
  final int trailerSize;
  final DateTime pickupDate;
  final DateTime deliveryDate;
  final List<String> hazmat;
  final int weight;
  final String deliveryInstruction;
  final String receiverEmail;
  final String receiverPhoneNumber;
  final String receiverName;
  final String receivingAddress;
  final String shipperEmail;
  final String shipperPhoneNumber;
  final String shipperName;
  final String shippingAddress;

  Load({
    this.loadType = "",
    this.palletSpace = 0,
    this.trailerSize = 0,
    DateTime? pickupDate,
    DateTime? deliveryDate,
    List<String>? hazmat,
    this.weight = 0,
    this.deliveryInstruction = "",
    this.receiverEmail = "",
    this.receiverPhoneNumber = "",
    this.receiverName = "",
    this.receivingAddress = "",
    this.shipperEmail = "",
    this.shipperPhoneNumber = "",
    this.shipperName = "",
    this.shippingAddress = "",
  })  : pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now(),
        hazmat = hazmat ?? [];

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      loadType: json['loadType'] ?? "",
      palletSpace: json['palletSpace'] ?? 0,
      trailerSize: json['trailerSize'] ?? 0,
      pickupDate: json['pickupDate'] != null
          ? DateTime.parse(json['pickupDate'])
          : DateTime.now(),
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : DateTime.now(),
      hazmat: List<String>.from(json['Hazmat'] ?? []),
      weight: json['weight'] ?? 0,
      deliveryInstruction: json['deliveryInstruction'] ?? "",
      receiverEmail: json['receiverEmail'] ?? "",
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
      receiverName: json['receiverName'] ?? "",
      receivingAddress: json['receivingAddress'] ?? "",
      shipperEmail: json['shipperEmail'] ?? "",
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
      shipperName: json['shipperName'] ?? "",
      shippingAddress: json['shippingAddress'] ?? "",
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
      'deliveryInstruction': deliveryInstruction,
      'receiverEmail': receiverEmail,
      'receiverPhoneNumber': receiverPhoneNumber,
      'receiverName': receiverName,
      'receivingAddress': receivingAddress,
      'shipperEmail': shipperEmail,
      'shipperPhoneNumber': shipperPhoneNumber,
      'shipperName': shipperName,
      'shippingAddress': shippingAddress,
    };
  }
}

class Truck {
  final String truckNumber;
  final int trailerSize;
  final int palletSpace;

  Truck({
    this.truckNumber = "",
    this.trailerSize = 0,
    this.palletSpace = 0,
  });

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      truckNumber: json['truckNumber'] ?? "",
      trailerSize: json['trailerSize'] ?? 0,
      palletSpace: json['palletSpace'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'truckNumber': truckNumber,
      'trailerSize': trailerSize,
      'palletSpace': palletSpace,
    };
  }
}
