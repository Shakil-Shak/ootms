
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
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  int palletSpace;
  String loadType;
  int trailerSize;
  String productType;
  String receiverPhoneNumber;
  String receiverEmail;
  String receivingAddress;
  DateTime pickupDate;
  DateTime deliveryDate;

  Query({
    this.id = '',
    User? user,
    this.shipperPhoneNumber = '',
    this.shipperEmail = '',
    this.shippingAddress = '',
    this.palletSpace = 0,
    this.loadType = '',
    this.trailerSize = 0,
    this.productType = '',
    this.receiverPhoneNumber = '',
    this.receiverEmail = '',
    this.receivingAddress = '',
    DateTime? pickupDate,
    DateTime? deliveryDate,
  })  : user = user ?? User(),
        pickupDate = pickupDate ?? DateTime.now(),
        deliveryDate = deliveryDate ?? DateTime.now();

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      id: json['_id'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : User(),
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? '',
      shipperEmail: json['shipperEmail'] ?? '',
      shippingAddress: json['shippingAddress'] ?? '',
      palletSpace: json['palletSpace'] ?? 0,
      loadType: json['loadType'] ?? '',
      trailerSize: json['trailerSize'] ?? 0,
      productType: json['productType'] ?? '',
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? '',
      receiverEmail: json['receiverEmail'] ?? '',
      receivingAddress: json['receivingAddress'] ?? '',
      pickupDate: json['pickupDate'] != null
          ? DateTime.parse(json['pickupDate'])
          : DateTime.now(),
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : DateTime.now(),
    );
  }
}

class User {
  String id;
  String image;

  User({
    this.id = '',
    this.image = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
