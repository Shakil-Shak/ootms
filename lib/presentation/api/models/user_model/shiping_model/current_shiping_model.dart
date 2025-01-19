class CurrentShippingModel {
  String id;
  String status;
  User user;
  Driver driver;
  String sender;
  Load load;
  Truck truck;
  String shippingId;
  String createdAt;
  String updatedAt;

  CurrentShippingModel({
    this.id = "",
    this.status = "",
    User? user,
    Driver? driver,
    this.sender = "",
    Load? load,
    Truck? truck,
    this.shippingId = "",
    this.createdAt = "",
    this.updatedAt = "",
  })  : user = user ?? User(),
        driver = driver ?? Driver(),
        load = load ?? Load(),
        truck = truck ?? Truck();

  factory CurrentShippingModel.fromJson(Map<String, dynamic> json) {
    return CurrentShippingModel(
      id: json["_id"] ?? "",
      status: json["status"] ?? "",
      user: json["user"] != null ? User.fromJson(json["user"]) : User(),
      driver: json["driver"] != null ? Driver.fromJson(json["driver"]) : Driver(),
      sender: json["sender"] ?? "",
      load: json["load"] != null ? Load.fromJson(json["load"]) : Load(),
      truck: json["truck"] != null ? Truck.fromJson(json["truck"]) : Truck(),
      shippingId: json["shippingId"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
}

class User {
  String id;
  String fullName;
  String image;

  User({this.id = "", this.fullName = "", this.image = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"] ?? "",
      fullName: json["fullName"] ?? "",
      image: json["image"] ?? "",
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
      id: json["_id"] ?? "",
      fullName: json["fullName"] ?? "",
      email: json["email"] ?? "",
      image: json["image"] ?? "",
      address: json["address"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
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
  String pickupDate;
  String deliveryDate;
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
    this.hazmat = const [],
    this.receiverName = "",
    this.receiverPhoneNumber = "",
    this.receiverEmail = "",
    this.receivingAddress = "",
    this.pickupDate = "",
    this.deliveryDate = "",
    this.deliveryInstruction = "",
  });

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      id: json["_id"] ?? "",
      shipperName: json["shipperName"] ?? "",
      shipperPhoneNumber: json["shipperPhoneNumber"] ?? "",
      shipperEmail: json["shipperEmail"] ?? "",
      shippingAddress: json["shippingAddress"] ?? "",
      palletSpace: json["palletSpace"] ?? 0,
      weight: json["weight"] ?? 0,
      loadType: json["loadType"] ?? "",
      trailerSize: json["trailerSize"] ?? 0,
      hazmat: (json["Hazmat"] as List<dynamic>?)?.cast<String>() ?? [],
      receiverName: json["receiverName"] ?? "",
      receiverPhoneNumber: json["receiverPhoneNumber"] ?? "",
      receiverEmail: json["receiverEmail"] ?? "",
      receivingAddress: json["receivingAddress"] ?? "",
      pickupDate: json["pickupDate"] ?? "",
      deliveryDate: json["deliveryDate"] ?? "",
      deliveryInstruction: json["deliveryInstruction"] ?? "",
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
      id: json["_id"] ?? "",
      truckNumber: json["truckNumber"] ?? "",
      trailerSize: json["trailerSize"] ?? 0,
    );
  }
}






