class DriverLoadModel {
  String id;
  String status;
  Driver driver;
  Load load;
  Truck truck;
  User user;
  num availablePalletSpace;

  DriverLoadModel({
    this.id = '',
    this.status = 'Pending',
    Driver? driver,
    Load? load,
    Truck? truck,
    User? user,
    this.availablePalletSpace = 0,
  })  : driver = driver ?? Driver(),
        load = load ?? Load(),
        truck = truck ?? Truck(),
        user = user ?? User();

  // Factory constructor for creating an instance from JSON
  factory DriverLoadModel.fromJson(Map<String, dynamic> json) {
    return DriverLoadModel(
      id: json['id'] ?? '',
      status: json['status'] ?? 'Pending',
      driver: Driver.fromJson(json['driver'] ?? {}),
      load: Load.fromJson(json['load'] ?? {}),
      truck: Truck.fromJson(json['truck'] ?? {}),
      user: User.fromJson(json['user'] ?? {}),
      availablePalletSpace: json['availablePalletSpace'] ?? 0,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'driver': driver.toJson(),
      'load': load.toJson(),
      'truck': truck.toJson(),
      'user': user.toJson(),
      'availablePalletSpace': availablePalletSpace,
    };
  }

  @override
  String toString() {
    return 'DriverLoadModel(id: $id, status: $status, driver: $driver, load: $load, truck: $truck, user: $user, availablePalletSpace: $availablePalletSpace)';
  }
}

class Driver {
  String fullName;
  String email;
  String phoneNumber;
  String address;
  String image;
  double ratings;

  Driver({
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.address = '',
    this.image = '',
    this.ratings = 0,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
      ratings: json['ratings'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'image': image,
      'ratings': ratings,
    };
  }

  @override
  String toString() {
    return 'Driver(fullName: $fullName, email: $email, phoneNumber: $phoneNumber, address: $address, image: $image, ratings: $ratings)';
  }
}

class Load {
  String id;
  String loadType;
  num palletSpace;
  num trailerSize;
  DateTime? pickupDate;
  DateTime? deliveryDate;
  List<String> hazmat;
  num weight;
  String deliveryInstruction;
  String receiverEmail;
  String receiverPhoneNumber;
  String receiverName;
  String receivingAddress;
  String shipperEmail;
  String shipperPhoneNumber;
  String shipperName;
  String shippingAddress;
  String description;

  Load({
    this.id = '',
    this.loadType = '',
    this.palletSpace = 0,
    this.trailerSize = 0,
    this.pickupDate,
    this.deliveryDate,
    this.hazmat = const [],
    this.weight = 0,
    this.deliveryInstruction = '',
    this.receiverEmail = '',
    this.receiverPhoneNumber = '',
    this.receiverName = '',
    this.receivingAddress = '',
    this.shipperEmail = '',
    this.shipperPhoneNumber = '',
    this.shipperName = '',
    this.shippingAddress = '',
    this.description = '',
  });

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      id: json['_id'] ?? '',
      loadType: json['loadType'] ?? '',
      palletSpace: json['palletSpace'] ?? 0,
      trailerSize: json['trailerSize'] ?? 0,
      pickupDate: json['pickupDate'] != null
          ? DateTime.parse(json['pickupDate'])
          : null,
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      hazmat: List<String>.from(json['Hazmat'] ?? []),
      weight: json['weight'] ?? 0,
      deliveryInstruction: json['deliveryInstruction'] ?? '',
      receiverEmail: json['receiverEmail'] ?? '',
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? '',
      receiverName: json['receiverName'] ?? '',
      receivingAddress: json['receivingAddress'] ?? '',
      shipperEmail: json['shipperEmail'] ?? '',
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? '',
      shipperName: json['shipperName'] ?? '',
      shippingAddress: json['shippingAddress'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'loadType': loadType,
      'palletSpace': palletSpace,
      'trailerSize': trailerSize,
      'pickupDate': pickupDate?.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'Hazmat': hazmat,
      'weight': weight,
      'deliveryInstruction': deliveryInstruction,
      'receiverEmail': receiverEmail,
      'receiverPhoneNumber': receiverPhoneNumber,
      'receiverName': receiverName,
      'receivingAddress': receivingAddress,
      'shipperEmail': shipperEmail,
      'shipperPhoneNumber': shipperPhoneNumber,
      'shipperName': shipperName,
      'shippingAddress': shippingAddress,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Load(id: $id, shipperName: $shipperName, receiverName: $receiverName, loadType: $loadType, palletSpace: $palletSpace, weight: $weight)';
  }
}

class Truck {
  String truckNumber;
  num trailerSize;
  num palletSpace;

  Truck({
    this.truckNumber = '',
    this.trailerSize = 0,
    this.palletSpace = 0,
  });

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      truckNumber: json['truckNumber'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      palletSpace: json['palletSpace'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'truckNumber': truckNumber,
      'trailerSize': trailerSize,
      'palletSpace': palletSpace,
    };
  }

  @override
  String toString() {
    return 'Truck(truckNumber: $truckNumber, trailerSize: $trailerSize, palletSpace: $palletSpace)';
  }
}

class User {
  String fullName;
  String image;
  num ratings;

  User({
    this.fullName = '',
    this.image = '',
    this.ratings = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
      ratings: json['ratings'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'image': image,
      'ratings': ratings,
    };
  }

  @override
  String toString() {
    return 'User(fullName: $fullName, image: $image, ratings: $ratings)';
  }
}
