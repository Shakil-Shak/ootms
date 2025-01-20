

class BOLTrackingModel {
  String id;
  String user;
  String shipperName;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  String shippingCity;
  String shippingState;
  String shippingZip;
  int palletSpace;
  double weight;
  String loadType;
  int trailerSize;
  String productType;
  List<String> hazmat;
  String description;
  double shipmentPayment;
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
  DriverModel driver;
  LocationModel location;
  DateTime createdAt;
  DateTime updatedAt;
  String receiverId;

  BOLTrackingModel({
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
    this.weight = 0.0,
    this.loadType = "",
    this.trailerSize = 0,
    this.productType = "",
    this.hazmat = const [],
    this.description = "",
    this.shipmentPayment = 0.0,
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
    DriverModel? driver,
    LocationModel? location,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.receiverId = "",
  })  : pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        driver = driver ?? DriverModel(),
        location = location ?? LocationModel();

  factory BOLTrackingModel.fromJson(Map<String, dynamic> json) {
    return BOLTrackingModel(
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
      weight: (json['weight'] ?? 0).toDouble(),
      loadType: json['loadType'] ?? "",
      trailerSize: json['trailerSize'] ?? 0,
      productType: json['productType'] ?? "",
      hazmat: List<String>.from(json['Hazmat'] ?? []),
      description: json['description'] ?? "",
      shipmentPayment: (json['shipmentPayment'] ?? 0).toDouble(),
      receiverName: json['receiverName'] ?? "",
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
      receiverEmail: json['receiverEmail'] ?? "",
      receivingAddress: json['receivingAddress'] ?? "",
      receiverCity: json['receiverCity'] ?? "",
      receiverState: json['receiverState'] ?? "",
      receiverZip: json['receiverZip'] ?? "",
      receiverPostalCode: json['receiverpostalCode'] ?? "",
      pickupDate: json['pickupDate'] != null ? DateTime.parse(json['pickupDate']) : null,
      deliveryDate: json['deliveryDate'] != null ? DateTime.parse(json['deliveryDate']) : null,
      billOfLading: json['billOfLading'] ?? "",
      deliveryInstruction: json['deliveryInstruction'] ?? "",
      driver: json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      location: json['location'] != null ? LocationModel.fromJson(json['location']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      receiverId: json['receiverId'] ?? "",
    );
  }
}

class DriverModel {
  String id;
  String userId;
  String fullName;
  String email;
  String password;
  bool isOnDuty;
  bool isComplete;
  bool validDriver;
  bool isSocialLogin;
  bool isDeleted;
  double ratings;
  int remainingDispatch;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  LocationModel location;
  String address;
  String phoneNumber;

  DriverModel({
    this.id = "",
    this.userId = "",
    this.fullName = "",
    this.email = "",
    this.password = "",
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = false,
    this.isSocialLogin = false,
    this.isDeleted = false,
    this.ratings = 0.0,
    this.remainingDispatch = 0,
    this.role = "",
    DateTime? createdAt,
    DateTime? updatedAt,
    LocationModel? location,
    this.address = "",
    this.phoneNumber = "",
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        location = location ?? LocationModel();

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      isOnDuty: json['isOnDuty'] ?? false,
      isComplete: json['isComplete'] ?? false,
      validDriver: json['validDriver'] ?? false,
      isSocialLogin: json['isSocialLogin'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      ratings: (json['ratings'] ?? 0).toDouble(),
      remainingDispatch: json['remainingDispatch'] ?? 0,
      role: json['role'] ?? "",
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      location: json['location'] != null ? LocationModel.fromJson(json['location']) : null,
      address: json['address'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
    );
  }
}

class LocationModel {
  String type;
  List<double> coordinates;

  LocationModel({
    this.type = "Point",
    this.coordinates = const [0.0, 0.0],
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'] ?? "Point",
      coordinates: List<double>.from(json['coordinates'] ?? [0.0, 0.0]),
    );
  }
}
