
class LoadRequestModel {
  Driver driver;
  Load load;
  Truck truck;
  int availablePalletSpace;

  LoadRequestModel({
    required this.driver,
    required this.load,
    required this.truck,
    required this.availablePalletSpace,
  });

  factory LoadRequestModel.fromJson(Map<String, dynamic> json) {
    return LoadRequestModel(
      driver: Driver.fromJson(json['driver'] ?? {}),
      load: Load.fromJson(json['load'] ?? {}),
      truck: Truck.fromJson(json['truck'] ?? {}),
      availablePalletSpace: json['availablePalletSpace'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driver': driver.toJson(),
      'load': load.toJson(),
      'truck': truck.toJson(),
      'availablePalletSpace': availablePalletSpace,
    };
  }

  factory LoadRequestModel.defaultValue() {
    return LoadRequestModel(
      driver: Driver.defaultValue(),
      load: Load.defaultValue(),
      truck: Truck.defaultValue(),
      availablePalletSpace: 0,
    );
  }
}

class Driver {
  String fullName;
  String email;
  String phoneNumber;
  String address;
  String image;

  Driver({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.image,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      fullName: json['fullName'] ?? 'Nasif Rahaman',
      email: json['email'] ?? 'mailto:kelaw98401@chansd.com',
      phoneNumber: json['phoneNumber'] ?? '01798552923',
      address: json['address'] ?? 'Dhaka',
      image: json['image'] ?? '/uploads/users/images-1735992334776.jpg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'image': image,
    };
  }

  factory Driver.defaultValue() {
    return Driver(
      fullName: 'Nasif Rahaman',
      email: 'mailto:kelaw98401@chansd.com',
      phoneNumber: '01798552923',
      address: 'Dhaka',
      image: '/uploads/users/images-1735992334776.jpg',
    );
  }
}

class Load {
  String loadType;
  int palletSpace;
  int trailerSize;
  DateTime pickupDate;
  DateTime deliveryDate;
  List hazmat;
  int weight;

  Load({
    required this.loadType,
    required this.palletSpace,
    required this.trailerSize,
    required this.pickupDate,
    required this.deliveryDate,
    required this.hazmat,
    required this.weight,
  });

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      loadType: json['loadType'] ?? 'Full Load',
      palletSpace: json['palletSpace'] ?? 10,
      trailerSize: json['trailerSize'] ?? 500,
      pickupDate: DateTime.parse(json['pickupDate'] ?? '2025-01-10T08:00:00.000Z'),
      deliveryDate: DateTime.parse(json['deliveryDate'] ?? '2025-01-12T18:00:00.000Z'),
       hazmat: json['Hazmat'] != null
          ? List<String>.from(json['Hazmat'])
          : [],
      weight: json['weight'] ?? 1500,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loadType': loadType,
      'palletSpace': palletSpace,
      'trailerSize': trailerSize,
      'pickupDate': pickupDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'Hazmat': hazmat,
      'weight': weight,
    };
  }

  factory Load.defaultValue() {
    return Load(
      loadType: 'Full Load',
      palletSpace: 10,
      trailerSize: 500,
      pickupDate: DateTime.parse('2025-01-10T08:00:00.000Z'),
      deliveryDate: DateTime.parse('2025-01-12T18:00:00.000Z'),
      hazmat: [],
      weight: 1500,
    );
  }
}

class Truck {
  String truckNumber;
  int trailerSize;
  int palletSpace;

  Truck({
    required this.truckNumber,
    required this.trailerSize,
    required this.palletSpace,
  });

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      truckNumber: json['truckNumber'] ?? 'TRK123456',
      trailerSize: json['trailerSize'] ?? 50,
      palletSpace: json['palletSpace'] ?? 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'truckNumber': truckNumber,
      'trailerSize': trailerSize,
      'palletSpace': palletSpace,
    };
  }

  factory Truck.defaultValue() {
    return Truck(
      truckNumber: 'TRK123456',
      trailerSize: 50,
      palletSpace: 10,
    );
  }
}
