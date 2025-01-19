
class PendingShipmentModel {
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

  PendingShipmentModel({
    this.id = "",
    this.status = "",
    User? user,
    Driver? driver,
    this.sender = "",
    Load? load,
    Truck? truck,
    this.shippingId = "",
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : user = user ?? User(),
        driver = driver ?? Driver(),
        load = load ?? Load(),
        truck = truck ?? Truck(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory PendingShipmentModel.fromJson(Map<String, dynamic> json) {
    return PendingShipmentModel(
      id: json['_id'] ?? "",
      status: json['status'] ?? "",
      user: User.fromJson(json['user'] ?? {}),
      driver: Driver.fromJson(json['driver'] ?? {}),
      sender: json['sender'] ?? "",
      load: Load.fromJson(json['load'] ?? {}),
      truck: Truck.fromJson(json['truck'] ?? {}),
      shippingId: json['shippingId'] ?? "",
      createdAt: DateTime.tryParse(json['createdAt'] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? "") ?? DateTime.now(),
    );
  }
}

class User {
  String id;
  String fullName;
  String image;

  User({
    this.id = "",
    this.fullName = "",
    this.image = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? "",
      fullName: json['fullName'] ?? "",
      image: json['image'] ?? "",
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

  Driver({
    this.id = "",
    this.fullName = "",
    this.email = "",
    this.image = "",
    this.address = "",
    this.phoneNumber = "",
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
      address: json['address'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
    );
  }
}

class Load {
  String id;
  String shipperName;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  int palletSpace;
  int weight;
  String loadType;
  int trailerSize;
  List<String> hazmat;
  String receiverName;
  String receiverPhoneNumber;
  String receiverEmail;
  String receivingAddress;
  DateTime pickupDate;
  DateTime deliveryDate;
  String deliveryInstruction;

  Load({
    this.id = "",
    this.shipperName = "",
    this.shipperPhoneNumber = "",
    this.shipperEmail = "",
    this.shippingAddress = "",
    this.palletSpace = 0,
    this.weight = 0,
    this.loadType = "",
    this.trailerSize = 0,
    List<String>? hazmat,
    this.receiverName = "",
    this.receiverPhoneNumber = "",
    this.receiverEmail = "",
    this.receivingAddress = "",
    DateTime? pickupDate,
    DateTime? deliveryDate,
    this.deliveryInstruction = "",
  })  : hazmat = hazmat ?? [],
        pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now();

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      id: json['_id'] ?? "",
      shipperName: json['shipperName'] ?? "",
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
      shipperEmail: json['shipperEmail'] ?? "",
      shippingAddress: json['shippingAddress'] ?? "",
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      loadType: json['loadType'] ?? "",
      trailerSize: json['trailerSize'] ?? 0,
      hazmat: List<String>.from(json['Hazmat'] ?? []),
      receiverName: json['receiverName'] ?? "",
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
      receiverEmail: json['receiverEmail'] ?? "",
      receivingAddress: json['receivingAddress'] ?? "",
      pickupDate: DateTime.tryParse(json['pickupDate'] ?? "") ?? DateTime.now(),
      deliveryDate: DateTime.tryParse(json['deliveryDate'] ?? "") ?? DateTime.now(),
      deliveryInstruction: json['deliveryInstruction'] ?? "",
    );
  }
}

class Truck {
  String id;
  String truckNumber;
  int trailerSize;

  Truck({
    this.id = "",
    this.truckNumber = "",
    this.trailerSize = 0,
  });

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      id: json['_id'] ?? "",
      truckNumber: json['truckNumber'] ?? "",
      trailerSize: json['trailerSize'] ?? 0,
    );
  }
}
