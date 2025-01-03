class CurrentShippingModel {
  Data data;

  CurrentShippingModel({
    required this.data,
  });

  factory CurrentShippingModel.fromJson(Map<String, dynamic> json) {
    return CurrentShippingModel(
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class Data {
  String type;
  Attributes attributes;

  Data({
    this.type = "load Request",
    required this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      type: json['type'] ?? "load Request",
      attributes: Attributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'attributes': attributes.toJson(),
    };
  }
}

class Attributes {
  List<LoadRequest> loadRequests;
  Pagination pagination;

  Attributes({
    required this.loadRequests,
    required this.pagination,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      loadRequests: (json['loadRequests'] as List)
          .map((item) => LoadRequest.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loadRequests': loadRequests.map((item) => item.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class LoadRequest {
  String id;
  String user;
  Driver driver;
  String sender;
  Load load;
  String status;
  int version;
  String createdAt;
  String updatedAt;

  LoadRequest({
    this.id = "",
    this.user = "",
    required this.driver,
    this.sender = "",
    required this.load,
    this.status = "",
    this.version = 0,
    this.createdAt = "",
    this.updatedAt = "",
  });

  factory LoadRequest.fromJson(Map<String, dynamic> json) {
    return LoadRequest(
      id: json['_id'] ?? "",
      user: json['user'] ?? "",
      driver: Driver.fromJson(json['driver']),
      sender: json['sender'] ?? "",
      load: Load.fromJson(json['load']),
      status: json['status'] ?? "",
      version: json['__v'] ?? 0,
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'driver': driver.toJson(),
      'sender': sender,
      'load': load.toJson(),
      'status': status,
      '__v': version,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Driver {
  String id;
  String fullName;
  String email;
  String image;

  Driver({
    this.id = "",
    this.fullName = "",
    this.email = "",
    this.image = "",
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
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

class Load {
  String id;
  String shipperPhoneNumber;
  String shipperEmail;
  String shippingAddress;
  String hazmat;
  String receiverPhoneNumber;
  String receiverEmail;
  String receivingAddress;
  int palletSpace;

  Load({
    this.id = "",
    this.shipperPhoneNumber = "",
    this.shipperEmail = "",
    this.shippingAddress = "",
    this.hazmat = "",
    this.receiverPhoneNumber = "",
    this.receiverEmail = "",
    this.receivingAddress = "",
    this.palletSpace = 0,
  });

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      id: json['_id'] ?? "",
      shipperPhoneNumber: json['shipperPhoneNumber'] ?? "",
      shipperEmail: json['shipperEmail'] ?? "",
      shippingAddress: json['shippingAddress'] ?? "",
      hazmat: json['Hazmat'] ?? "",
      receiverPhoneNumber: json['receiverPhoneNumber'] ?? "",
      receiverEmail: json['receiverEmail'] ?? "",
      receivingAddress: json['receivingAddress'] ?? "",
      palletSpace: json['palletSpace'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'shipperPhoneNumber': shipperPhoneNumber,
      'shipperEmail': shipperEmail,
      'shippingAddress': shippingAddress,
      'Hazmat': hazmat,
      'receiverPhoneNumber': receiverPhoneNumber,
      'receiverEmail': receiverEmail,
      'receivingAddress': receivingAddress,
      'palletSpace': palletSpace,
    };
  }
}

class Pagination {
  int totalResults;
  int totalPages;
  int currentPage;
  int limit;

  Pagination({
    this.totalResults = 0,
    this.totalPages = 0,
    this.currentPage = 0,
    this.limit = 0,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalResults: json['totalResults'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalResults': totalResults,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'limit': limit,
    };
  }
}
