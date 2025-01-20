

class EquipmentModel {
  List<Truck> truck;
  List<Trailer> trailer;

  EquipmentModel({
    this.truck = const [],
    this.trailer = const [],
  });

  factory EquipmentModel.fromJson(Map<String, String> json) {
    return EquipmentModel(
      truck: (json['truck'] as List<Map<String, String>>?)
              ?.map((e) => Truck.fromJson(e))
              .toList() ??
          [],
      trailer: (json['trailer'] as List<Map<String, String>>?)
              ?.map((e) => Trailer.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'truck': truck.map((e) => e.toJson()).toList(),
      'trailer': trailer.map((e) => e.toJson()).toList(),
    };
  }
}

class Truck {
  String id;
  String driver;
  String type;
  String cdlNumber;
  String truckNumber;
  int trailerSize;
  int palletSpace;
  int weight;
  int version;
  DateTime createdAt;
  DateTime updatedAt;

  Truck({
    this.id = '',
    this.driver = '',
    this.type = '',
    this.cdlNumber = '',
    this.truckNumber = '',
    this.trailerSize = 0,
    this.palletSpace = 0,
    this.weight = 0,
    this.version = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck(
      id: json['_id'] ?? '',
      driver: json['driver'] ?? '',
      type: json['type'] ?? '',
      cdlNumber: json['cdlNumber'] ?? '',
      truckNumber: json['truckNumber'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      version: json['__v'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'driver': driver,
      'type': type,
      'cdlNumber': cdlNumber,
      'truckNumber': truckNumber,
      'trailerSize': trailerSize,
      'palletSpace': palletSpace,
      'weight': weight,
      '__v': version,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Trailer {
  String id;
  String driver;
  String type;
  int trailerSize;
  int palletSpace;
  int weight;
  int version;
  DateTime createdAt;
  DateTime updatedAt;

  Trailer({
    this.id = '',
    this.driver = '',
    this.type = '',
    this.trailerSize = 0,
    this.palletSpace = 0,
    this.weight = 0,
    this.version = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      id: json['_id'] ?? '',
      driver: json['driver'] ?? '',
      type: json['type'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      version: json['__v'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'driver': driver,
      'type': type,
      'trailerSize': trailerSize,
      'palletSpace': palletSpace,
      'weight': weight,
      '__v': version,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
