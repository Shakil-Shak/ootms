
class NearestLoadModel {
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
  LoadLocation location;
  num distance;
  DateTime createdAt;
  DateTime updatedAt;

  NearestLoadModel({
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
    LoadLocation? location,
    this.distance = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now(),
        location = location ?? LoadLocation(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory NearestLoadModel.fromJson(Map<String, dynamic> json) {
    return NearestLoadModel(
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
      hazmat: (json['Hazmat'] is List)
          ? List<String>.from(json['Hazmat'])
          : [],
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
      pickupDate: DateTime.tryParse(json['pickupDate'] ?? '') ?? DateTime.now(),
      deliveryDate: DateTime.tryParse(json['deliveryDate'] ?? '') ?? DateTime.now(),
      billOfLading: json['billOfLading'] ?? "",
      deliveryInstruction: json['deliveryInstruction'] ?? "",
      location: LoadLocation.fromJson(json['location'] ?? {}),
      distance: json['distance'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class LoadLocation {
  String type;
  List<num> coordinates;

  LoadLocation({
    this.type = "Pikachu",
    this.coordinates = const [0.0, 0.0],
  });

  factory LoadLocation.fromJson(Map<String, dynamic> json) {
    return LoadLocation(
      type: json['type'] ?? "Pikachu",
      coordinates: List<num>.from(json['coordinates'] ?? [0.0, 0.0]),
    );
  }
}

