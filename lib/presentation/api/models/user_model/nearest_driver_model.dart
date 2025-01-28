
class NearestDriverModel {
  final String id;
  final String userId;
  final String fullName;
  final String email;
  final String image;
  final bool isOnDuty;
  final bool isComplete;
  final bool validDriver;
  final bool isSocialLogin;
  final bool isDeleted;
  final num ratings;
  final num remainingDispatch;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String address;
  final String cdlNumberImage;
  final String phoneNumber;
  final DriverLocation location;
  final double distance;
  final Truck truck;

  NearestDriverModel({
    this.id = '',
    this.userId = '',
    this.fullName = '',
    this.email = '',
    this.image = '',
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = false,
    this.isSocialLogin = false,
    this.isDeleted = false,
    this.ratings = 0,
    this.remainingDispatch = 0,
    this.role = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.address = '',
    this.cdlNumberImage = '',
    this.phoneNumber = '',
    DriverLocation? location,
    this.distance = 0.0,
    Truck? truck,
  })  : location = location ?? DriverLocation(),
        truck = truck ?? Truck();

  factory NearestDriverModel.fromJson(Map<String, dynamic> json) {
    return NearestDriverModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      isOnDuty: json['isOnDuty'] ?? false,
      isComplete: json['isComplete'] ?? false,
      validDriver: json['validDriver'] ?? false,
      isSocialLogin: json['isSocialLogin'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      ratings: json['ratings'] ?? 0,
      remainingDispatch: json['remainingDispatch'] ?? 0,
      role: json['role'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      address: json['address'] ?? '',
      cdlNumberImage: json['cdlNumberImage'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      location: DriverLocation.fromJson(json['location'] ?? {}),
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      truck: Truck.fromJson(json['truck'] ?? {}),
    );
  }
}

class Truck {
  final String id;
  final String driver;
  final String cdlNumber;
  final String truckNumber;
  final num trailerSize;
  final num palletSpace;
  final num weight;
  final num availablePalletSpace;
  final String createdAt;
  final String updatedAt;

  Truck({
    this.id = '',
    this.driver = '',
    this.cdlNumber = '',
    this.truckNumber = '',
    this.trailerSize = 0,
    this.palletSpace = 0,
    this.weight = 0,
    this.availablePalletSpace = 0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      id: json['_id'] ?? '',
      driver: json['driver'] ?? '',
      cdlNumber: json['cdlNumber'] ?? '',
      truckNumber: json['truckNumber'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      availablePalletSpace: json['availablePalletSpace'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class DriverLocation {
  String type;
  List<num> coordinates;

  DriverLocation({
    this.type = "Point",
    List<num>? coordinates,
  }) : coordinates = coordinates ?? [];

  factory DriverLocation.fromJson(Map<String, dynamic> json) {
    return DriverLocation(
      type: json['type'] ?? "Point",
      coordinates: (json['coordinates'] as List?)?.map((e) => (e as num).toDouble()).toList() ?? [],
    );
  }
}

class LoadLocationModel {
  String type;
  List<num> coordinates;

  LoadLocationModel({
    this.type = "",
    List<num>? coordinates,
  }) : coordinates = coordinates ?? [];

  factory LoadLocationModel.fromJson(Map<String, dynamic> json) {
    return LoadLocationModel(
      type: json['type'] ?? "",
      coordinates: List<num>.from(json['coordinates'] ?? []),
    );
  }
}
