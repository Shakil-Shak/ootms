

class CurrentShippingModel {
  final String type;
  final List<LoadRequest> loadRequests;
  final Pagination pagination;

  CurrentShippingModel({
    required this.type,
    required this.loadRequests,
    required this.pagination,
  });

  factory CurrentShippingModel.fromJson(Map<String, dynamic> json) {
    return CurrentShippingModel(
      type: json['type'],
      loadRequests: (json['attributes']['loadRequests'] as List)
          .map((item) => LoadRequest.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['attributes']['pagination']),
    );
  }
}

class LoadRequest {
  final String id;
  final Driver driver;
  final Load load;
  final String status;

  LoadRequest({
    required this.id,
    required this.driver,
    required this.load,
    required this.status,
  });

  factory LoadRequest.fromJson(Map<String, dynamic> json) {
    return LoadRequest(
      id: json['_id'],
      driver: Driver.fromJson(json['driver']),
      load: Load.fromJson(json['load']),
      status: json['status'],
    );
  }
}

class Driver {
  final String id;
  final String fullName;
  final String email;
  final String image;

  Driver({
    required this.id,
    required this.fullName,
    required this.email,
    required this.image,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      image: json['image'],
    );
  }
}

class Load {
  final String id;
  final String shipperPhoneNumber;
  final String shipperEmail;
  final String shippingAddress;
  final String hazmat;
  final String receiverPhoneNumber;
  final String receiverEmail;
  final String receivingAddress;
  final int palletSpace;

  Load({
    required this.id,
    required this.shipperPhoneNumber,
    required this.shipperEmail,
    required this.shippingAddress,
    required this.hazmat,
    required this.receiverPhoneNumber,
    required this.receiverEmail,
    required this.receivingAddress,
    required this.palletSpace,
  });

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      id: json['_id'],
      shipperPhoneNumber: json['shipperPhoneNumber'],
      shipperEmail: json['shipperEmail'],
      shippingAddress: json['shippingAddress'],
      hazmat: json['Hazmat'],
      receiverPhoneNumber: json['receiverPhoneNumber'],
      receiverEmail: json['receiverEmail'],
      receivingAddress: json['receivingAddress'],
      palletSpace: json['palletSpace'],
    );
  }
}

class Pagination {
  final int totalResults;
  final int totalPages;
  final int currentPage;
  final int limit;

  Pagination({
    required this.totalResults,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalResults: json['totalResults'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      limit: json['limit'],
    );
  }
}
