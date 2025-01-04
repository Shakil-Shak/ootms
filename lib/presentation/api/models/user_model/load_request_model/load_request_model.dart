class LoadRequestModel {
  String? id;
  User? user;
  Driver? driver;
  Sender? sender;
  Load? load;
  String status;
  int version;
  DateTime createdAt;
  DateTime updatedAt;

  LoadRequestModel({
    this.id,
    this.user,
    this.driver,
    this.sender,
    this.load,
    this.status = "Pending",
    this.version = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory LoadRequestModel.fromJson(Map<String, dynamic> json) {
    return LoadRequestModel(
      id: json['_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
      load: json['load'] != null ? Load.fromJson(json['load']) : null,
      status: json['status'] ?? "Pending",
      version: json['__v'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class User {
  String? id;

  User({this.id});

  factory User.fromJson(dynamic json) {
    return User(
      id: json,
    );
  }
}

class Driver {
  String? id;
  String fullName;
  String email;
  String image;
  String address;
  String phoneNumber;

  Driver({
    this.id,
    this.fullName = "",
    this.email = "",
    this.image = "",
    this.address = "",
    this.phoneNumber = "",
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'],
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
      address: json['address'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
    );
  }

}

class Sender {
  String? id;

  Sender({this.id});

  factory Sender.fromJson(dynamic json) {
    return Sender(
      id: json,
    );
  }
}

class Load {
  String? id;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  String hazmat;
  String receiverPhoneNumber;
  String receiverEmail;
  String receivingAddress;
  int palletSpace;

  Load({
    this.id,
    this.shipperPhoneNumber = "",
    this.shipperEmail = "",
    this.shippingAddress = "",
    this.hazmat = "",
    this.receiverPhoneNumber = "",
    this.receiverEmail = "",
    this.receivingAddress = "",
    this.palletSpace = 0,
  });

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      id: json['_id'],
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
      shipperEmail: json['shipperEmail'] ?? "",
      shippingAddress: json['shippingAddress'] ?? "",
      hazmat: json['Hazmat'] ?? "",
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
      receiverEmail: json['receiverEmail'] ?? "",
      receivingAddress: json['receivingAddress'] ?? "",
      palletSpace: json['palletSpace'] ?? 0,
    );
  }
}
