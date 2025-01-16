

class PendingShipmentModel {
  String id;
  String user;
  Driver driver;
  String sender;
  Load load;
  Truck truck;
  String status;
  int version;
  DateTime createdAt;
  DateTime updatedAt;

  PendingShipmentModel({
    this.id = "",
    this.user = "",
    Driver? driver,
    this.sender = "",
    Load? load,
    Truck? truck,
    this.status = "Pending",
    this.version = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : driver = driver ?? Driver(),
        load = load ?? Load(),
        truck = truck ?? Truck(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory PendingShipmentModel.fromJson(Map<String, dynamic> json) {
    return PendingShipmentModel(
      id: json['_id'] ?? "",
      user: json['user'] ?? "",
      driver: Driver.fromJson(json['driver'] ?? {}),
      sender: json['sender'] ?? "",
      load: Load.fromJson(json['load'] ?? {}),
      truck: Truck.fromJson(json['truck'] ?? {}),
      status: json['status'] ?? "Pending",
      version: json['__v'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? "") ?? DateTime.now(),
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
  List<dynamic> hazmat;
  String id;
  String shipperName;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  int palletSpace;
  int weight;
  String loadType;
  int trailerSize;
  String receiverName;
  String receiverPhoneNumber;
  String receiverEmail;
  String receivingAddress;
  DateTime pickupDate;
  DateTime deliveryDate;
  String deliveryInstruction;

  Load({
    this.hazmat = const [],
    this.id = "",
    this.shipperName = "",
    this.shipperPhoneNumber = "",
    this.shipperEmail = "",
    this.shippingAddress = "",
    this.palletSpace = 0,
    this.weight = 0,
    this.loadType = "",
    this.trailerSize = 0,
    this.receiverName = "",
    this.receiverPhoneNumber = "",
    this.receiverEmail = "",
    this.receivingAddress = "",
    DateTime? pickupDate,
    DateTime? deliveryDate,
    this.deliveryInstruction = "",
  })  : pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now();

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      hazmat: json['Hazmat'] ?? [],
      id: json['_id'] ?? "",
      shipperName: json['shipperName'] ?? "",
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
      shipperEmail: json['shipperEmail'] ?? "",
      shippingAddress: json['shippingAddress'] ?? "",
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      loadType: json['loadType'] ?? "",
      trailerSize: json['trailerSize'] ?? 0,
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
