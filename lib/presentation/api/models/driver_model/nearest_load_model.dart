
class NearestLoadModel {
  final String id;
  final UserModel user;
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
  final List<String> hazmat;
  final String description;
  final int shipmentPayment;
  final String receiverName;
  final String receiverPhoneNumber;
  final String receiverEmail;
  final String receivingAddress;
  final String receiverCity;
  final String receiverState;
  final String receiverZip;
  final DateTime pickupDate;
  final DateTime deliveryDate;
  final String billOfLading;
  final String deliveryInstruction;
  final LoadLocation location;
  final double distance;

  NearestLoadModel({
    this.id = '',
    UserModel? user,
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
    DateTime? pickupDate,
    DateTime? deliveryDate,
    this.billOfLading = '',
    this.deliveryInstruction = '',
    LoadLocation? location,
    this.distance = 0.0,
  })  : user = user ?? UserModel(),
        pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now(),
        location = location ?? LoadLocation();

  factory NearestLoadModel.fromJson(Map<String, dynamic> json) {
    return NearestLoadModel(
      id: json['_id'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
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
      pickupDate: DateTime.tryParse(json['pickupDate'] ?? '') ?? DateTime.now(),
      deliveryDate: DateTime.tryParse(json['deliveryDate'] ?? '') ?? DateTime.now(),
      billOfLading: json['billOfLading'] ?? '',
      deliveryInstruction: json['deliveryInstruction'] ?? '',
      location: LoadLocation.fromJson(json['location'] ?? {}),
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class UserModel {
  final String userImage;
  final String userId;
  final String userName;
  final String userEmail;

  UserModel({
    this.userImage = '',
    this.userId = '',
    this.userName = '',
    this.userEmail = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userImage: json['userImage'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userEmail: json['userEmail'] ?? '',
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

