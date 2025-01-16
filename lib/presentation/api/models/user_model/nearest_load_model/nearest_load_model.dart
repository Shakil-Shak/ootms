

import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearestLoadModel {
  String id;
  String userId;
  String shipperName;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  String shippingCity;
  String shippingState;
  String shippingZip;
  int palletSpace;
  int weight;
  String loadType;
  int trailerSize;
  String productType;
  List<String> hazmat;
  String description;
  int shipmentPayment;
  String receiverName;
  String receiverPhoneNumber;
  String receiverEmail;
  String receivingAddress;
  String receiverCity;
  String receiverState;
  String receiverZip;
  String receiverPostalCode;
  DateTime pickupDate;
  DateTime deliveryDate;
  String billOfLading;
  String deliveryInstruction;
  LatLng location;
  int version;
  DateTime createdAt;
  DateTime updatedAt;
  double distance;

  NearestLoadModel({
    this.id = "",
    this.userId = "",
    this.shipperName = "",
    this.shipperPhoneNumber = "",
    this.shipperEmail = "",
    this.shippingAddress = "",
    this.shippingCity = "",
    this.shippingState = "",
    this.shippingZip = "",
    this.palletSpace = 0,
    this.weight = 0,
    this.loadType = "",
    this.trailerSize = 0,
    this.productType = "",
    this.hazmat = const [],
    this.description = "",
    this.shipmentPayment = 0,
    this.receiverName = "",
    this.receiverPhoneNumber = "",
    this.receiverEmail = "",
    this.receivingAddress = "",
    this.receiverCity = "",
    this.receiverState = "",
    this.receiverZip = "",
    this.receiverPostalCode = "",
    DateTime? pickupDate,
    DateTime? deliveryDate,
    this.billOfLading = "",
    this.deliveryInstruction = "",
    this.location = const LatLng(0, 0),
    this.version = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.distance = 0.0,
  })  : pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory NearestLoadModel.fromJson(Map<String, dynamic> json) {
    return NearestLoadModel(
      id: json['_id'] ?? "",
      userId: json['user'] ?? "",
      shipperName: json['shipperName'] ?? "",
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
      shipperEmail: json['shipperEmail'] ?? "",
      shippingAddress: json['shippingAddress'] ?? "",
      shippingCity: json['shippingCity'] ?? "",
      shippingState: json['shippingState'] ?? "",
      shippingZip: json['shippingZip'] ?? "",
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      loadType: json['loadType'] ?? "",
      trailerSize: json['trailerSize'] ?? 0,
      productType: json['productType'] ?? "",
      hazmat: List<String>.from(json['Hazmat'] ?? []),
      description: json['description'] ?? "",
      shipmentPayment: json['shipmentPayment'] ?? 0,
      receiverName: json['receiverName'] ?? "",
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
      receiverEmail: json['receiverEmail'] ?? "",
      receivingAddress: json['receivingAddress'] ?? "",
      receiverCity: json['receiverCity'] ?? "",
      receiverState: json['receiverState'] ?? "",
      receiverZip: json['receiverZip'] ?? "",
      receiverPostalCode: json['receiverpostalCode'] ?? "",
      pickupDate: DateTime.tryParse(json['pickupDate'] ?? "") ?? DateTime.now(),
      deliveryDate: DateTime.tryParse(json['deliveryDate'] ?? "") ?? DateTime.now(),
      billOfLading: json['billOfLading'] ?? "",
      deliveryInstruction: json['deliveryInstruction'] ?? "",
      location: LatLng(
        (json['location']['coordinates'] ?? [0, 0])[1],
        (json['location']['coordinates'] ?? [0, 0])[0],
      ),
      version: json['__v'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? "") ?? DateTime.now(),
      distance: (json['distance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'shipperName': shipperName,
      'shipperPhoneNumber': shipperPhoneNumber,
      'shipperEmail': shipperEmail,
      'shippingAddress': shippingAddress,
      'shippingCity': shippingCity,
      'shippingState': shippingState,
      'shippingZip': shippingZip,
      'palletSpace': palletSpace,
      'weight': weight,
      'loadType': loadType,
      'trailerSize': trailerSize,
      'productType': productType,
      'Hazmat': hazmat,
      'description': description,
      'shipmentPayment': shipmentPayment,
      'receiverName': receiverName,
      'receiverPhoneNumber': receiverPhoneNumber,
      'receiverEmail': receiverEmail,
      'receivingAddress': receivingAddress,
      'receiverCity': receiverCity,
      'receiverState': receiverState,
      'receiverZip': receiverZip,
      'receiverpostalCode': receiverPostalCode,
      'pickupDate': pickupDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'billOfLading': billOfLading,
      'deliveryInstruction': deliveryInstruction,
      'location': {
        'type': 'Point',
        'coordinates': [location.longitude, location.latitude],
      },
      '__v': version,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'distance': distance,
    };
  }
}
