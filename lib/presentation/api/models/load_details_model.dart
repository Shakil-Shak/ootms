
class LoadDetailsModel {
  String type;
  Attributes attributes;

  LoadDetailsModel({
    this.type = '',
    Attributes? attributes,
  }) : attributes = attributes ?? Attributes();

  factory LoadDetailsModel.fromJson(Map<String, dynamic> json) {
    return LoadDetailsModel(
      type: json['type'] ?? '',
      attributes: json['attributes'] != null
          ? Attributes.fromJson(json['attributes'])
          : Attributes(),
    );
  }
}

class Attributes {
  Query query;

  Attributes({
    Query? query,
  }) : query = query ?? Query();

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      query: json['query'] != null ? Query.fromJson(json['query']) : Query(),
    );
  }
}

class Query {
  String id;
  User user;
  String shipperName;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  int palletSpace;
  int weight;
  String loadType;
  int trailerSize;
  String productType;
  List<String> hazmat;
  String description;
  String receiverName;
  String receiverPhoneNumber;
  String receiverEmail;
  String receivingAddress;
  DateTime pickupDate;
  DateTime deliveryDate;

  Query({
    this.id = "",
    User? user,
    this.shipperName = "",
    this.shipperPhoneNumber = "",
    this.shipperEmail = "",
    this.shippingAddress = "",
    this.palletSpace = 0,
    this.weight = 0,
    this.loadType = "",
    this.trailerSize = 0,
    this.productType = "",
    this.hazmat = const [],
    this.description = "",
    this.receiverName = "",
    this.receiverPhoneNumber = "",
    this.receiverEmail = "",
    this.receivingAddress = "",
    DateTime? pickupDate,
    DateTime? deliveryDate,
  })  : user = user ?? User(),
        pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now();

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      id: json['_id'] ?? "",
      user: User.fromJson(json['user'] ?? {}),
      shipperName: json['shipperName'] ?? "",
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
      shipperEmail: json['shipperEmail'] ?? "",
      shippingAddress: json['shippingAddress'] ?? "",
      palletSpace: json['palletSpace'] ?? 0,
      weight: json['weight'] ?? 0,
      loadType: json['loadType'] ?? "",
      trailerSize: json['trailerSize'] ?? 0,
      productType: json['productType'] ?? "",
      hazmat: List<String>.from(json['Hazmat'] ?? []),
      description: json['description'] ?? "",
      receiverName: json['receiverName'] ?? "",
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
      receiverEmail: json['receiverEmail'] ?? "",
      receivingAddress: json['receivingAddress'] ?? "",
      pickupDate: DateTime.tryParse(json['pickupDate'] ?? '') ?? DateTime.now(),
      deliveryDate: DateTime.tryParse(json['deliveryDate'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user.toJson(),
      'shipperName': shipperName,
      'shipperPhoneNumber': shipperPhoneNumber,
      'shipperEmail': shipperEmail,
      'shippingAddress': shippingAddress,
      'palletSpace': palletSpace,
      'weight': weight,
      'loadType': loadType,
      'trailerSize': trailerSize,
      'productType': productType,
      'Hazmat': hazmat,
      'description': description,
      'receiverName': receiverName,
      'receiverPhoneNumber': receiverPhoneNumber,
      'receiverEmail': receiverEmail,
      'receivingAddress': receivingAddress,
      'pickupDate': pickupDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
    };
  }
}

class User {
  String id;
  String fullName;
  String email;
  String image;

  User({
    this.id = "",
    this.fullName = "",
    this.email = "",
    this.image = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'image': image,
    };
  }
}

