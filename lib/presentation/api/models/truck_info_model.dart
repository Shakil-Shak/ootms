
class TruckInfoModel {
  final String id;
  final String driver;
  final String cdlNumber;
  final String truckNumber;
  final int trailerSize;
  final int palletSpace;
  final int weight;
  final DateTime createdAt;
  final DateTime updatedAt;

  TruckInfoModel({
    this.id = "",
    this.driver = "",
    this.cdlNumber = "",
    this.truckNumber = "",
    this.trailerSize = 0,
    this.palletSpace = 0,
    this.weight = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory TruckInfoModel.fromJson(Map<String, dynamic> json) {
    return TruckInfoModel(
      id: json['_id'] ?? "",
      driver: json['driver'] ?? "",
      cdlNumber: json['cdlNumber'] ?? "",
      truckNumber: json['truckNumber'] ?? "",
      trailerSize: json['trailerSize'] ?? 0,
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }
}