

// class DriverProfileModel {
//   UserDetails userDetails;
//   List<TruckDetails> truckDetails;

//   DriverProfileModel({
//     this.userDetails = const UserDetails(),
//     this.truckDetails = const [],
//   });

//   factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
//     return DriverProfileModel(
//       userDetails: UserDetails.fromJson(json['userDetails'] ?? {}),
//       truckDetails: (json['truckDetails'] as List<dynamic>? ?? [])
//           .map((e) => TruckDetails.fromJson(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'userDetails': userDetails.toJson(),
//       'truckDetails': truckDetails.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class UserDetails {
//   final String document;
//   final int remainingDispatch;
//   final String id;
//   final String userId;
//   final String fullName;
//   final String email;
//   final String image;
//   final bool isOnDuty;
//   final bool isComplete;
//   final bool validDriver;
//   final double ratings;
//   final int dispatchCompleted;
//   final String role;
//   final String createdAt;
//   final String updatedAt;
//   final String address;
//   final String phoneNumber;
//   final bool isDeleted;

//   const UserDetails({
//     this.document = '',
//     this.remainingDispatch = 0,
//     this.id = '',
//     this.userId = '',
//     this.fullName = '',
//     this.email = '',
//     this.image = '',
//     this.isOnDuty = false,
//     this.isComplete = false,
//     this.validDriver = false,
//     this.ratings = 0.0,
//     this.dispatchCompleted = 0,
//     this.role = '',
//     this.createdAt = '',
//     this.updatedAt = '',
//     this.address = '',
//     this.phoneNumber = '',
//     this.isDeleted = false,
//   });

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return UserDetails(
//       document: json['document'] ?? '',
//       remainingDispatch: json['remainingDispatch'] ?? 0,
//       id: json['_id'] ?? '',
//       userId: json['userId'] ?? '',
//       fullName: json['fullName'] ?? '',
//       email: json['email'] ?? '',
//       image: json['image'] ?? '',
//       isOnDuty: json['isOnDuty'] ?? false,
//       isComplete: json['isComplete'] ?? false,
//       validDriver: json['validDriver'] ?? false,
//       ratings: (json['ratings'] ?? 0.0).toDouble(),
//       dispatchCompleted: json['dispatchCompleted'] ?? 0,
//       role: json['role'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       address: json['address'] ?? '',
//       phoneNumber: json['phoneNumber'] ?? '',
//       isDeleted: json['isDeleted'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'document': document,
//       'remainingDispatch': remainingDispatch,
//       '_id': id,
//       'userId': userId,
//       'fullName': fullName,
//       'email': email,
//       'image': image,
//       'isOnDuty': isOnDuty,
//       'isComplete': isComplete,
//       'validDriver': validDriver,
//       'ratings': ratings,
//       'dispatchCompleted': dispatchCompleted,
//       'role': role,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'address': address,
//       'phoneNumber': phoneNumber,
//       'isDeleted': isDeleted,
//     };
//   }
// }

// class TruckDetails {
//   final int weight;
//   final String id;
//   final String driver;
//   final String cdlNumber;
//   final String truckNumber;
//   final int trailerSize;
//   final int palletSpace;
//   final String createdAt;
//   final String updatedAt;

//   const TruckDetails({
//     this.weight = 0,
//     this.id = '',
//     this.driver = '',
//     this.cdlNumber = '',
//     this.truckNumber = '',
//     this.trailerSize = 0,
//     this.palletSpace = 0,
//     this.createdAt = '',
//     this.updatedAt = '',
//   });

//   factory TruckDetails.fromJson(Map<String, dynamic> json) {
//     return TruckDetails(
//       weight: json['weight'] ?? 0,
//       id: json['_id'] ?? '',
//       driver: json['driver'] ?? '',
//       cdlNumber: json['cdlNumber'] ?? '',
//       truckNumber: json['truckNumber'] ?? '',
//       trailerSize: json['trailerSize'] ?? 0,
//       palletSpace: json['palletSpace'] ?? 0,
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'weight': weight,
//       '_id': id,
//       'driver': driver,
//       'cdlNumber': cdlNumber,
//       'truckNumber': truckNumber,
//       'trailerSize': trailerSize,
//       'palletSpace': palletSpace,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//     };
//   }

//   @override
//   String toString() {
//     return 'TruckDetails(id: $id, driver: $driver, cdlNumber: $cdlNumber, truckNumber: $truckNumber, trailerSize: $trailerSize, palletSpace: $palletSpace, weight: $weight)';
//   }
// }




class DriverProfileModel {
  final UserDetails userDetails;
  final List<TruckDetails> truckDetails;

  DriverProfileModel({
    required this.userDetails,
    this.truckDetails = const [],
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      userDetails: UserDetails.fromJson(json['userDetails']),
      truckDetails: (json['truckDetails'] as List<dynamic>?)
              ?.map((item) => TruckDetails.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userDetails': userDetails.toJson(),
      'truckDetails': truckDetails.map((item) => item.toJson()).toList(),
    };
  }
}

class UserDetails {
  final Location location;
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
  final double ratings;
  final int remainingDispatch;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String address;
  final String cdlNumberImage;
  final String phoneNumber;

  UserDetails({
    required this.location,
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
    this.ratings = 0.0,
    this.remainingDispatch = 0,
    this.role = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.address = '',
    this.cdlNumberImage = '',
    this.phoneNumber = '',
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      location: Location.fromJson(json['location']),
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
      ratings: (json['ratings'] ?? 0).toDouble(),
      remainingDispatch: json['remainingDispatch'] ?? 0,
      role: json['role'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      address: json['address'] ?? '',
      cdlNumberImage: json['cdlNumberImage'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      '_id': id,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'image': image,
      'isOnDuty': isOnDuty,
      'isComplete': isComplete,
      'validDriver': validDriver,
      'isSocialLogin': isSocialLogin,
      'isDeleted': isDeleted,
      'ratings': ratings,
      'remainingDispatch': remainingDispatch,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'address': address,
      'cdlNumberImage': cdlNumberImage,
      'phoneNumber': phoneNumber,
    };
  }
}

class Location {
  final String type;
  final List<dynamic> coordinates;

  Location({
    this.type = '',
    this.coordinates = const [],
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List<dynamic>?)?.map((e) => e.toDouble()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

class TruckDetails {
  final String id;
  final String driver;
  final String cdlNumber;
  final String truckNumber;
  final int trailerSize;
  final int palletSpace;
  final int availablePalletSpace;
  final int weight;
  final DateTime createdAt;
  final DateTime updatedAt;

  TruckDetails({
    this.id = '',
    this.driver = '',
    this.cdlNumber = '',
    this.truckNumber = '',
    this.trailerSize = 0,
    this.palletSpace = 0,
    this.availablePalletSpace = 0,
    this.weight = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory TruckDetails.fromJson(Map<String, dynamic> json) {
    return TruckDetails(
      id: json['_id'] ?? '',
      driver: json['driver'] ?? '',
      cdlNumber: json['cdlNumber'] ?? '',
      truckNumber: json['truckNumber'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      palletSpace: json['palletSpace'] ?? 0,
      availablePalletSpace: json['availablePalletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'driver': driver,
      'cdlNumber': cdlNumber,
      'truckNumber': truckNumber,
      'trailerSize': trailerSize,
      'palletSpace': palletSpace,
      'availablePalletSpace': availablePalletSpace,
      'weight': weight,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
