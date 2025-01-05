

// class CurrentShippingModel {
//   final String type;
//   final List<LoadRequest> loadRequests;
//   final Pagination pagination;

//   CurrentShippingModel({
//     required this.type,
//     required this.loadRequests,
//     required this.pagination,
//   });

//   factory CurrentShippingModel.fromJson(Map<String, dynamic> json) {
//     return CurrentShippingModel(
//       type: json['type'],
//       loadRequests: (json['attributes']['loadRequests'] as List)
//           .map((item) => LoadRequest.fromJson(item))
//           .toList(),
//       pagination: Pagination.fromJson(json['attributes']['pagination']),
//     );
//   }
// }

// class LoadRequest {
//   final String id;
//   final Driver driver;
//   final Load load;
//   final String status;

//   LoadRequest({
//     required this.id,
//     required this.driver,
//     required this.load,
//     required this.status,
//   });

//   factory LoadRequest.fromJson(Map<String, dynamic> json) {
//     return LoadRequest(
//       id: json['_id'],
//       driver: Driver.fromJson(json['driver']),
//       load: Load.fromJson(json['load']),
//       status: json['status'],
//     );
//   }
// }

// class Driver {
//   final String id;
//   final String fullName;
//   final String email;
//   final String image;

//   Driver({
//     required this.id,
//     required this.fullName,
//     required this.email,
//     required this.image,
//   });

//   factory Driver.fromJson(Map<String, dynamic> json) {
//     return Driver(
//       id: json['_id'],
//       fullName: json['fullName'],
//       email: json['email'],
//       image: json['image'],
//     );
//   }
// }

// class Load {
//   final String id;
//   final String shipperPhoneNumber;
//   final String shipperEmail;
//   final String shippingAddress;
//   final String hazmat;
//   final String receiverPhoneNumber;
//   final String receiverEmail;
//   final String receivingAddress;
//   final int palletSpace;

//   Load({
//     required this.id,
//     required this.shipperPhoneNumber,
//     required this.shipperEmail,
//     required this.shippingAddress,
//     required this.hazmat,
//     required this.receiverPhoneNumber,
//     required this.receiverEmail,
//     required this.receivingAddress,
//     required this.palletSpace,
//   });

//   factory Load.fromJson(Map<String, dynamic> json) {
//     return Load(
//       id: json['_id'],
//       shipperPhoneNumber: json['shipperPhoneNumber'],
//       shipperEmail: json['shipperEmail'],
//       shippingAddress: json['shippingAddress'],
//       hazmat: json['Hazmat'],
//       receiverPhoneNumber: json['receiverPhoneNumber'],
//       receiverEmail: json['receiverEmail'],
//       receivingAddress: json['receivingAddress'],
//       palletSpace: json['palletSpace'],
//     );
//   }
// }

// class Pagination {
//   final int totalResults;
//   final int totalPages;
//   final int currentPage;
//   final int limit;

//   Pagination({
//     required this.totalResults,
//     required this.totalPages,
//     required this.currentPage,
//     required this.limit,
//   });

//   factory Pagination.fromJson(Map<String, dynamic> json) {
//     return Pagination(
//       totalResults: json['totalResults'],
//       totalPages: json['totalPages'],
//       currentPage: json['currentPage'],
//       limit: json['limit'],
//     );
//   }
// }


class CurrentShippingModel {
  String id;
  String user;
  Driver driver;
  String sender;
  Load load;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  CurrentShippingModel({
    required this.id,
    required this.user,
    required this.driver,
    required this.sender,
    required this.load,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrentShippingModel.fromJson(Map<String, dynamic> json) {
    return CurrentShippingModel(
      id: json['_id'] ?? 'default_id',
      user: json['user'] ?? 'default_user',
      driver: Driver.fromJson(json['driver'] ?? {}),
      sender: json['sender'] ?? 'default_sender',
      load: Load.fromJson(json['load'] ?? {}),
      status: json['status'] ?? 'Pending',
      createdAt: DateTime.parse(json['createdAt'] ?? '2025-01-01T00:00:00.000Z'),
      updatedAt: DateTime.parse(json['updatedAt'] ?? '2025-01-01T00:00:00.000Z'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'driver': driver.toJson(),
      'sender': sender,
      'load': load.toJson(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory CurrentShippingModel.defaultValue() {
    return CurrentShippingModel(
      id: 'default_id',
      user: 'default_user',
      driver: Driver.defaultValue(),
      sender: 'default_sender',
      load: Load.defaultValue(),
      status: 'Pending',
      createdAt: DateTime.parse('2025-01-01T00:00:00.000Z'),
      updatedAt: DateTime.parse('2025-01-01T00:00:00.000Z'),
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
  String shipperName;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  int palletSpace;
  int weight;
  String loadType;
  int trailerSize;
  String hazmat;
  String receiverName;
  String receiverPhoneNumber;
  String receiverEmail;
  String receivingAddress;
  DateTime pickupDate;
  DateTime deliveryDate;
  String deliveryInstruction;

  Load({
    required this.shipperName,
    required this.shipperPhoneNumber,
    required this.shipperEmail,
    required this.shippingAddress,
    required this.palletSpace,
    required this.weight,
    required this.loadType,
    required this.trailerSize,
    required this.hazmat,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.receiverEmail,
    required this.receivingAddress,
    required this.pickupDate,
    required this.deliveryDate,
    required this.deliveryInstruction,
  });

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      shipperName: json['shipperName'] ?? 'John Doe',
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? '+1234567890',
      shipperEmail: json['shipperEmail'] ?? 'shipper@example.com',
      shippingAddress: json['shippingAddress'] ?? '123 Main Street',
      palletSpace: json['palletSpace'] ?? 10,
      weight: json['weight'] ?? 1500,
      loadType: json['loadType'] ?? 'Full Load',
      trailerSize: json['trailerSize'] ?? 500,
      hazmat: json['Hazmat'] ?? 'Class 2',
      receiverName: json['receiverName'] ?? 'Jane Doe',
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? '+0987654321',
      receiverEmail: json['receiverEmail'] ?? 'receiver@example.com',
      receivingAddress: json['receivingAddress'] ?? '456 Elm Street',
      pickupDate: DateTime.parse(json['pickupDate'] ?? '2025-01-10T08:00:00.000Z'),
      deliveryDate: DateTime.parse(json['deliveryDate'] ?? '2025-01-12T18:00:00.000Z'),
      deliveryInstruction: json['deliveryInstruction'] ?? 'Handle with care, keep refrigerated.',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipperName': shipperName,
      'shipperPhoneNumber': shipperPhoneNumber,
      'shipperEmail': shipperEmail,
      'shippingAddress': shippingAddress,
      'palletSpace': palletSpace,
      'weight': weight,
      'loadType': loadType,
      'trailerSize': trailerSize,
      'Hazmat': hazmat,
      'receiverName': receiverName,
      'receiverPhoneNumber': receiverPhoneNumber,
      'receiverEmail': receiverEmail,
      'receivingAddress': receivingAddress,
      'pickupDate': pickupDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'deliveryInstruction': deliveryInstruction,
    };
  }

  factory Load.defaultValue() {
    return Load(
      shipperName: 'John Doe',
      shipperPhoneNumber: '+1234567890',
      shipperEmail: 'shipper@example.com',
      shippingAddress: '123 Main Street',
      palletSpace: 10,
      weight: 1500,
      loadType: 'Full Load',
      trailerSize: 500,
      hazmat: 'Class 2',
      receiverName: 'Jane Doe',
      receiverPhoneNumber: '+0987654321',
      receiverEmail: 'receiver@example.com',
      receivingAddress: '456 Elm Street',
      pickupDate: DateTime.parse('2025-01-10T08:00:00.000Z'),
      deliveryDate: DateTime.parse('2025-01-12T18:00:00.000Z'),
      deliveryInstruction: 'Handle with care, keep refrigerated.',
    );
  }
}
