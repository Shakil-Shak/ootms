class CurrentShippingModel {
  String id;
  String status;
  User user;
  Driver driver;
  String sender;
  Load load;
  Truck truck;
  String shippingId;
  DateTime createdAt;
  DateTime updatedAt;

  CurrentShippingModel({
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

  factory CurrentShippingModel.fromJson(Map<String, dynamic> json) {
    return CurrentShippingModel(
      id: json['_id'] ?? '',
      status: json['status'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      driver: Driver.fromJson(json['driver'] ?? {}),
      sender: json['sender'] ?? '',
      load: Load.fromJson(json['load'] ?? {}),
      truck: Truck.fromJson(json['truck'] ?? {}),
      shippingId: json['shippingId'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class User {
  String id;
  String fullName;
  String image;
  double ratings;

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
  String id;
  String fullName;
  String email;
  String image;
  String address;
  String phoneNumber;
  LocationModel location;
  double ratings;

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
      location: LocationModel.fromJson(json['location'] ?? {}),
      ratings: (json['ratings'] ?? 0).toDouble(),
    );
  }
}

class Load {
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
  LocationModel receiverLocation;
  LocationModel shipperLocation;
  String driver;
  String shipperToDriverChatId;
  String shipperToReceiverChatId;
  DateTime createdAt;
  DateTime updatedAt;

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
    this.weight = 0.0,
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
    this.driver = '',
    this.shipperToDriverChatId = '',
    this.shipperToReceiverChatId = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

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
      weight: (json['weight'] ?? 0).toDouble(),
      loadType: json['loadType'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      productType: json['productType'] ?? '',
      hazmat: List<String>.from(json['Hazmat'] ?? []),
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
      receiverLocation: LocationModel.fromJson(json['receiverLocation'] ?? {}),
      shipperLocation: LocationModel.fromJson(json['shipperLocation'] ?? {}),
      driver: json['driver'] ?? '',
      shipperToDriverChatId: json['shipperToDriverChatId'] ?? '',
      shipperToReceiverChatId: json['shipperToReceiverChatId'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class Truck {
  String id;
  String truckNumber;
  int trailerSize;

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

class LocationModel {
  String type;
  List<num> coordinates;

  LocationModel({
    this.type = '',
    this.coordinates = const [0.0, 0.0],
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'] ?? '',
      coordinates: List<num>.from(json['coordinates'] ?? [0.0, 0.0]),
    );
  }
}






