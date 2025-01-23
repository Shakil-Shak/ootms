
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
  LocationModel receiverLocation;
  LocationModel shipperLocation;
  String receiverId;
  DriverModel driver;
  String driverToReceiverChatId;
  String shipperToDriverChatId;
  String shipperToReceiverChatId;

  BOLTrackingModel({
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
    this.shipmentPayment = 0,
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
    LocationModel? receiverLocation,
    LocationModel? shipperLocation,
    this.receiverId = '',
    DriverModel? driver,
    this.driverToReceiverChatId = '',
    this.shipperToDriverChatId = '',
    this.shipperToReceiverChatId = '',
  })  : pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now(),
        receiverLocation = receiverLocation ?? LocationModel(),
        shipperLocation = shipperLocation ?? LocationModel(),
        driver = driver ?? DriverModel();

  factory BOLTrackingModel.fromJson(Map<String, dynamic> json) {
    return BOLTrackingModel(
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
      hazmat: List<String>.from(json['Hazmat'] ?? []),
      description: json['description'] ?? '',
      shipmentPayment: json['shipmentPayment'] ?? 0,
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
      receiverLocation: LocationModel.fromJson(json['receiverLocation'] ?? {}),
      shipperLocation: LocationModel.fromJson(json['shipperLocation'] ?? {}),
      receiverId: json['receiverId'] ?? '',
      driver: DriverModel.fromJson(json['driver'] ?? {}),
      driverToReceiverChatId: json['driverToReceiverChatId'] ?? '',
      shipperToDriverChatId: json['shipperToDriverChatId'] ?? '',
      shipperToReceiverChatId: json['shipperToReceiverChatId'] ?? '',
    );
  }
}

class LocationModel {
  String type;
  List<num> coordinates;

  LocationModel({
    this.type = 'Point',
    this.coordinates = const [0.0, 0.0],
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'] ?? 'Point',
      coordinates: List<num>.from(json['coordinates'] ?? [0.0, 0.0]),
    );
  }
}

class DriverModel {
  String id;
  String userId;
  String fullName;
  String email;
  String image;
  String password;
  bool isOnDuty;
  bool isComplete;
  bool validDriver;
  bool isSocialLogin;
  bool isDeleted;
  int ratings;
  int remainingDispatch;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  String address;
  String cdlNumberImage;
  String phoneNumber;
  LocationModel location;

  DriverModel({
    this.id = '',
    this.userId = '',
    this.fullName = '',
    this.email = '',
    this.image = '',
    this.password = '',
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = false,
    this.isSocialLogin = false,
    this.isDeleted = false,
    this.ratings = 0,
    this.remainingDispatch = 0,
    this.role = 'driver',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.address = '',
    this.cdlNumberImage = '',
    this.phoneNumber = '',
    LocationModel? location,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        location = location ?? LocationModel();

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      password: json['password'] ?? '',
      isOnDuty: json['isOnDuty'] ?? false,
      isComplete: json['isComplete'] ?? false,
      validDriver: json['validDriver'] ?? false,
      isSocialLogin: json['isSocialLogin'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      ratings: json['ratings'] ?? 0,
      remainingDispatch: json['remainingDispatch'] ?? 0,
      role: json['role'] ?? 'driver',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      address: json['address'] ?? '',
      cdlNumberImage: json['cdlNumberImage'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      location: LocationModel.fromJson(json['location'] ?? {}),
    );
  }
}
