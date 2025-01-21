class NearestLoadModel {
  final String id;
  final User user;
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
  final double shipmentPayment;
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
  final NearestLoadLocation receiverLocation;
  final NearestLoadLocation shipperLocation;
  final double distance;

  NearestLoadModel({
    this.id = "",
    User? user,
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
    this.shipmentPayment = 0.0,
    this.receiverName = "",
    this.receiverPhoneNumber = "",
    this.receiverEmail = "",
    this.receivingAddress = "",
    this.receiverCity = "",
    this.receiverState = "",
    this.receiverZip = "",
    DateTime? pickupDate,
    DateTime? deliveryDate,
    this.billOfLading = "",
    this.deliveryInstruction = "",
    NearestLoadLocation? receiverLocation,
    NearestLoadLocation? shipperLocation,
    this.distance = 0.0,
  })  : user = user ?? User(),
        hazmat = hazmat ?? [],
        pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now(),
        receiverLocation = receiverLocation ?? NearestLoadLocation(),
        shipperLocation = shipperLocation ?? NearestLoadLocation();

  factory NearestLoadModel.fromJson(Map<String, dynamic> json) {
    return NearestLoadModel(
      id: json['_id'] ?? "",
      user: json['user'] != null ? User.fromJson(json['user']) : User(),
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
      shipmentPayment: (json['shipmentPayment'] ?? 0).toDouble(),
      receiverName: json['receiverName'] ?? "",
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
      receiverEmail: json['receiverEmail'] ?? "",
      receivingAddress: json['receivingAddress'] ?? "",
      receiverCity: json['receiverCity'] ?? "",
      receiverState: json['receiverState'] ?? "",
      receiverZip: json['receiverZip'] ?? "",
      pickupDate: json['pickupDate'] != null
          ? DateTime.parse(json['pickupDate'])
          : DateTime.now(),
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : DateTime.now(),
      billOfLading: json['billOfLading'] ?? "",
      deliveryInstruction: json['deliveryInstruction'] ?? "",
      receiverLocation: json['receiverLocation'] != null
          ? NearestLoadLocation.fromJson(json['receiverLocation'])
          : NearestLoadLocation(),
      shipperLocation: json['shipperLocation'] != null
          ? NearestLoadLocation.fromJson(json['shipperLocation'])
          : NearestLoadLocation(),
      distance: (json['distance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user.toJson(),
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
      'pickupDate': pickupDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'billOfLading': billOfLading,
      'deliveryInstruction': deliveryInstruction,
      'receiverLocation': receiverLocation.toJson(),
      'shipperLocation': shipperLocation.toJson(),
      'distance': distance,
    };
  }
}

class User {
  final String userImage;
  final String userId;
  final String userName;
  final String userEmail;

  User({
    this.userImage = "",
    this.userId = "",
    this.userName = "",
    this.userEmail = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userImage: json['userImage'] ?? "",
      userId: json['userId'] ?? "",
      userName: json['userName'] ?? "",
      userEmail: json['userEmail'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userImage': userImage,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
    };
  }
}

class NearestLoadLocation {
  final String type;
  final List<double> coordinates;

  NearestLoadLocation({
    this.type = "Point",
    List<double>? coordinates,
  }) : coordinates = coordinates ?? [0.0, 0.0];

  factory NearestLoadLocation.fromJson(Map<String, dynamic> json) {
    return NearestLoadLocation(
      type: json['type'] ?? "Point",
      coordinates: List<double>.from(json['coordinates'] ?? [0.0, 0.0]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
