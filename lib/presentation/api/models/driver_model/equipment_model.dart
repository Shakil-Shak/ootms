class EquipmentModel {
  String id;
  String driver;
  String cdlNumber;
  String truckNumber;
  int trailerSize;
  int palletSpace;
  int version;
  DateTime createdAt;
  DateTime updatedAt;

  EquipmentModel({
    required this.id,
    required this.driver,
    required this.cdlNumber,
    required this.truckNumber,
    required this.trailerSize,
    required this.palletSpace,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor for creating an instance from JSON
  factory EquipmentModel.fromJson(Map<String, dynamic> json) {
    return EquipmentModel(
      id: json['_id'] ?? '',
      driver: json['driver'] ?? '',
      cdlNumber: json['cdlNumber'] ?? '',
      truckNumber: json['truckNumber'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      palletSpace: json['palletSpace'] ?? 0,
      version: json['__v'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'driver': driver,
      'cdlNumber': cdlNumber,
      'truckNumber': truckNumber,
      'trailerSize': trailerSize,
      'palletSpace': palletSpace,
      '__v': version,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Factory constructor for creating a default instance
  factory EquipmentModel.defaultValue() {
    return EquipmentModel(
      id: '',
      driver: '',
      cdlNumber: '',
      truckNumber: '',
      trailerSize: 0,
      palletSpace: 0,
      version: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
