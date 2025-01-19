
class PendingShipmentModel {
  Location location;
  String id;
  String user;
  String shipperName;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  String shippingCity;
  String shippingState;
  String shippingZip;
  num palletSpace;
  num weight;
  String loadType;
  num trailerSize;
  String productType;
  List<String> hazmat;
  String description;
  num shipmentPayment;
  String receiverId;
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
  DateTime createdAt;
  DateTime updatedAt;

  PendingShipmentModel({
    Location? location,
    this.id = "",
    this.user = "",
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
    List<String>? hazmat,
    this.description = "",
    this.shipmentPayment = 0,
    this.receiverId = "",
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
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : location = location ?? Location(),
        hazmat = hazmat ?? [],
        pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory PendingShipmentModel.fromJson(Map<String, dynamic> json) {
    return PendingShipmentModel(
      location: Location.fromJson(json['location'] ?? {}),
      id: json['_id'] ?? "",
      user: json['user'] ?? "",
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
      receiverId: json['receiverId'] ?? "",
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
      createdAt: DateTime.tryParse(json['createdAt'] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? "") ?? DateTime.now(),
    );
  }
}

class Location {
  String type;
  List<num> coordinates;

  Location({
    this.type = "",
    List<num>? coordinates,
  }) : coordinates = coordinates ?? [0.0, 0.0];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? "",
      coordinates: List<num>.from(json['coordinates'] ?? [0.0, 0.0]),
    );
  }
}
