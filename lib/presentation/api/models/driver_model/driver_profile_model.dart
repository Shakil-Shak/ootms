// class DriverProfileModel {
//   UserDetails? userDetails;
//   List<TruckDetails>? truckDetails;

//   DriverProfileModel({
//     this.userDetails,
//     this.truckDetails,
//   });

//   factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
//     return DriverProfileModel(
//       userDetails: UserDetails.fromJson(json['userDetails'] ?? {}),
//       truckDetails: (json['truckDetails'] as List<dynamic>? ?? [])
//           .map((e) => TruckDetails.fromJson(e))
//           .toList(),
//     );
//   }


//   @override
//   String toString() {
//     return 'DriverProfileModel(userDetails: $userDetails, truckDetails: $truckDetails)';
//   }
// }

// class UserDetails {
//   String id;
//   String userId;
//   String fullName;
//   String email;
//   String image;
//   bool isOnDuty;
//   bool isComplete;
//   bool validDriver;
//   int ratings;
//   int dispatchCompleted;
//   String role;
//   String createdAt;
//   String updatedAt;
//   String address;
//   bool isDeleted;
//   String phoneNumber;
//   Location location;

//   UserDetails({
//     this.id = '',
//     this.userId = '',
//     this.fullName = '',
//     this.email = '',
//     this.image = '',
//     this.isOnDuty = false,
//     this.isComplete = false,
//     this.validDriver = false,
//     this.ratings = 0,
//     this.dispatchCompleted = 0,
//     this.role = '',
//     this.createdAt = '',
//     this.updatedAt = '',
//     this.address = '',
//     this.isDeleted = false,
//     this.phoneNumber = '',
//     required this.location,
//   });

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return UserDetails(
//       id: json['_id'] ?? '',
//       userId: json['userId'] ?? '',
//       fullName: json['fullName'] ?? '',
//       email: json['email'] ?? '',
//       image: json['image'] ?? '',
//       isOnDuty: json['isOnDuty'] ?? false,
//       isComplete: json['isComplete'] ?? false,
//       validDriver: json['validDriver'] ?? false,
//       ratings: json['ratings'] ?? 0,
//       dispatchCompleted: json['dispatchCompleted'] ?? 0,
//       role: json['role'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       address: json['address'] ?? '',
//       isDeleted: json['isDeleted'] ?? false,
//       phoneNumber: json['phoneNumber'] ?? '',
//       location: Location.fromJson(json['location'] ?? {}),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
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
//       'isDeleted': isDeleted,
//       'phoneNumber': phoneNumber,
//       'location': location.toJson(),
//     };
//   }

//   @override
//   String toString() {
//     return 'UserDetails(id: $id, userId: $userId, fullName: $fullName, email: $email, isOnDuty: $isOnDuty, ratings: $ratings, address: $address, location: $location)';
//   }
// }

// class Location {
//   String type;
//   List<double> coordinates;

//   Location({
//     this.type = 'Point',
//     this.coordinates = const [0.0, 0.0],
//   });

//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       type: json['type'] ?? 'Point',
//       coordinates: List<double>.from(json['coordinates'] ?? [0.0, 0.0]),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'coordinates': coordinates,
//     };
//   }

//   @override
//   String toString() {
//     return 'Location(type: $type, coordinates: $coordinates)';
//   }
// }

// class TruckDetails {
//   String id;
//   String driver;
//   String cdlNumber;
//   String truckNumber;
//   int trailerSize;
//   int palletSpace;
//   int weight;
//   String createdAt;
//   String updatedAt;

//   TruckDetails({
//     this.id = '',
//     this.driver = '',
//     this.cdlNumber = '',
//     this.truckNumber = '',
//     this.trailerSize = 0,
//     this.palletSpace = 0,
//     this.weight = 0,
//     this.createdAt = '',
//     this.updatedAt = '',
//   });

//   factory TruckDetails.fromJson(Map<String, dynamic> json) {
//     return TruckDetails(
//       id: json['_id'] ?? '',
//       driver: json['driver'] ?? '',
//       cdlNumber: json['cdlNumber'] ?? '',
//       truckNumber: json['truckNumber'] ?? '',
//       trailerSize: json['trailerSize'] ?? 0,
//       palletSpace: json['palletSpace'] ?? 0,
//       weight: json['weight'] ?? 0,
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'driver': driver,
//       'cdlNumber': cdlNumber,
//       'truckNumber': truckNumber,
//       'trailerSize': trailerSize,
//       'palletSpace': palletSpace,
//       'weight': weight,
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
  UserDetails userDetails;
  List<TruckDetails> truckDetails;

  DriverProfileModel({
    this.userDetails = const UserDetails(),
    this.truckDetails = const [],
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      userDetails: UserDetails.fromJson(json['userDetails'] ?? {}),
      truckDetails: (json['truckDetails'] as List<dynamic>? ?? [])
          .map((e) => TruckDetails.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userDetails': userDetails.toJson(),
      'truckDetails': truckDetails.map((e) => e.toJson()).toList(),
    };
  }
}

class UserDetails {
  final String document;
  final int remainingDispatch;
  final String id;
  final String userId;
  final String fullName;
  final String email;
  final String image;
  final bool isOnDuty;
  final bool isComplete;
  final bool validDriver;
  final double ratings;
  final int dispatchCompleted;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String address;
  final String phoneNumber;
  final bool isDeleted;

  const UserDetails({
    this.document = '',
    this.remainingDispatch = 0,
    this.id = '',
    this.userId = '',
    this.fullName = '',
    this.email = '',
    this.image = '',
    this.isOnDuty = false,
    this.isComplete = false,
    this.validDriver = false,
    this.ratings = 0.0,
    this.dispatchCompleted = 0,
    this.role = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.address = '',
    this.phoneNumber = '',
    this.isDeleted = false,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      document: json['document'] ?? '',
      remainingDispatch: json['remainingDispatch'] ?? 0,
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      isOnDuty: json['isOnDuty'] ?? false,
      isComplete: json['isComplete'] ?? false,
      validDriver: json['validDriver'] ?? false,
      ratings: (json['ratings'] ?? 0.0).toDouble(),
      dispatchCompleted: json['dispatchCompleted'] ?? 0,
      role: json['role'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document': document,
      'remainingDispatch': remainingDispatch,
      '_id': id,
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'image': image,
      'isOnDuty': isOnDuty,
      'isComplete': isComplete,
      'validDriver': validDriver,
      'ratings': ratings,
      'dispatchCompleted': dispatchCompleted,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'address': address,
      'phoneNumber': phoneNumber,
      'isDeleted': isDeleted,
    };
  }
}

class TruckDetails {
  final int weight;
  final String id;
  final String driver;
  final String cdlNumber;
  final String truckNumber;
  final int trailerSize;
  final int palletSpace;
  final String createdAt;
  final String updatedAt;

  const TruckDetails({
    this.weight = 0,
    this.id = '',
    this.driver = '',
    this.cdlNumber = '',
    this.truckNumber = '',
    this.trailerSize = 0,
    this.palletSpace = 0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory TruckDetails.fromJson(Map<String, dynamic> json) {
    return TruckDetails(
      weight: json['weight'] ?? 0,
      id: json['_id'] ?? '',
      driver: json['driver'] ?? '',
      cdlNumber: json['cdlNumber'] ?? '',
      truckNumber: json['truckNumber'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      palletSpace: json['palletSpace'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      '_id': id,
      'driver': driver,
      'cdlNumber': cdlNumber,
      'truckNumber': truckNumber,
      'trailerSize': trailerSize,
      'palletSpace': palletSpace,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 'TruckDetails(id: $id, driver: $driver, cdlNumber: $cdlNumber, truckNumber: $truckNumber, trailerSize: $trailerSize, palletSpace: $palletSpace, weight: $weight)';
  }
}


