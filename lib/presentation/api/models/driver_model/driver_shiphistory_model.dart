import 'package:flutter/foundation.dart';

class DriverShipHistoryModel {
  final String id;
  final String status;
  final User user;
  final Driver driver;
  final String sender;
  final Load load;
  final Truck truck;
  final String shippingId;
  final DateTime createdAt;
  final DateTime updatedAt;

  DriverShipHistoryModel({
    this.id = '',
    this.status = '',
    required this.user,
    required this.driver,
    this.sender = '',
    required this.load,
    required this.truck,
    this.shippingId = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory DriverShipHistoryModel.fromJson(Map<String, dynamic> json) {
    return DriverShipHistoryModel(
      id: json['_id'] ?? '',
      status: json['status'] ?? '',
      user: User.fromJson(json['user']),
      driver: Driver.fromJson(json['driver']),
      sender: json['sender'] ?? '',
      load: Load.fromJson(json['load']),
      truck: Truck.fromJson(json['truck']),
      shippingId: json['shippingId'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class User {
  final String id;
  final String fullName;
  final String image;
  final double ratings;

  User({
    this.id = '',
    this.fullName = '',
    this.image = '',
    this.ratings = 0.0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
      ratings: (json['ratings'] ?? 0).toDouble(),
    );
  }
}

class Driver {
  final String id;
  final String fullName;
  final String email;
  final String image;
  final String address;
  final String phoneNumber;
  final Location location;
  final double ratings;

  Driver({
    this.id = '',
    this.fullName = '',
    this.email = '',
    this.image = '',
    this.address = '',
    this.phoneNumber = '',
    required this.location,
    this.ratings = 0.0,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      location: Location.fromJson(json['location']),
      ratings: (json['ratings'] ?? 0).toDouble(),
    );
  }
}

class Load {
  final String id;
  final String user;
  final String shipperName;
  final String shipperPhoneNumber;
  final String shipperEmail;
  final String shippingAddress;
  final String shippingCity;
  final String shippingState;
  final String shippingZip;
  final int palletSpace;
  final int weight;
  final String loadType;
  final int trailerSize;
  final String productType;
  final List<dynamic> hazmat;
  final String description;
  final double shipmentPayment;
  final String receiverName;
  final String receiverPhoneNumber;
  final String receiverEmail;
  final String receivingAddress;
  final String receiverCity;
  final String receiverState;
  final String receiverZip;
  final String receiverPostalCode;
  final DateTime pickupDate;
  final DateTime deliveryDate;
  final String billOfLading;
  final String deliveryInstruction;
  final Location receiverLocation;
  final Location shipperLocation;

  Load({
    this.id = '',
    this.user = '',
    this.shipperName = '',
    this.shipperPhoneNumber = '',
    this.shipperEmail = '',
    this.shippingAddress = '',
    this.shippingCity = '',
    this.shippingState = '',
    this.shippingZip = '',
    this.palletSpace = 0,
    this.weight = 0,
    this.loadType = '',
    this.trailerSize = 0,
    this.productType = '',
    this.hazmat = const [],
    this.description = '',
    this.shipmentPayment = 0.0,
    this.receiverName = '',
    this.receiverPhoneNumber = '',
    this.receiverEmail = '',
    this.receivingAddress = '',
    this.receiverCity = '',
    this.receiverState = '',
    this.receiverZip = '',
    this.receiverPostalCode = '',
    DateTime? pickupDate,
    DateTime? deliveryDate,
    this.billOfLading = '',
    this.deliveryInstruction = '',
    required this.receiverLocation,
    required this.shipperLocation,
  })  : pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now();

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      shipperName: json['shipperName'] ?? '',
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? '',
      shipperEmail: json['shipperEmail'] ?? '',
      shippingAddress: json['shippingAddress'] ?? '',
      shippingCity: json['shippingCity'] ?? '',
      shippingState: json['shippingState'] ?? '',
      shippingZip: json['shippingZip'] ?? '',
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      loadType: json['loadType'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      productType: json['productType'] ?? '',
      hazmat: json['Hazmat'] ?? [],
      description: json['description'] ?? '',
      shipmentPayment: (json['shipmentPayment'] ?? 0).toDouble(),
      receiverName: json['receiverName'] ?? '',
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? '',
      receiverEmail: json['receiverEmail'] ?? '',
      receivingAddress: json['receivingAddress'] ?? '',
      receiverCity: json['receiverCity'] ?? '',
      receiverState: json['receiverState'] ?? '',
      receiverZip: json['receiverZip'] ?? '',
      receiverPostalCode: json['receiverpostalCode'] ?? '',
      pickupDate: DateTime.tryParse(json['pickupDate'] ?? '') ?? DateTime.now(),
      deliveryDate: DateTime.tryParse(json['deliveryDate'] ?? '') ?? DateTime.now(),
      billOfLading: json['billOfLading'] ?? '',
      deliveryInstruction: json['deliveryInstruction'] ?? '',
      receiverLocation: Location.fromJson(json['receiverLocation']),
      shipperLocation: Location.fromJson(json['shipperLocation']),
    );
  }
}

class Truck {
  final String id;
  final String truckNumber;
  final int trailerSize;

  Truck({
    this.id = '',
    this.truckNumber = '',
    this.trailerSize = 0,
  });

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      id: json['_id'] ?? '',
      truckNumber: json['truckNumber'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
    );
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    this.type = 'Point',
    this.coordinates = const [0.0, 0.0],
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? 'Point',
      coordinates: List<double>.from(json['coordinates'] ?? [0.0, 0.0]),
    );
  }
}
