

class DirectionsModel {
  final List<GeocodedWaypoint> geocodedWaypoints;
  final List<Route> routes;

  DirectionsModel({
    required this.geocodedWaypoints,
    required this.routes,
  });

  factory DirectionsModel.fromJson(Map<String, dynamic> json) {
    return DirectionsModel(
      geocodedWaypoints: (json['geocoded_waypoints'] as List)
          .map((e) => GeocodedWaypoint.fromJson(e))
          .toList(),
      routes: (json['routes'] as List).map((e) => Route.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geocoded_waypoints':
      geocodedWaypoints.map((e) => e.toJson()).toList(),
      'routes': routes.map((e) => e.toJson()).toList(),
    };
  }
}

class GeocodedWaypoint {
  final String geocoderStatus;
  final String placeId;
  final List<String> types;

  GeocodedWaypoint({
    required this.geocoderStatus,
    required this.placeId,
    required this.types,
  });

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) {
    return GeocodedWaypoint(
      geocoderStatus: json['geocoder_status'],
      placeId: json['place_id'],
      types: List<String>.from(json['types']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geocoder_status': geocoderStatus,
      'place_id': placeId,
      'types': types,
    };
  }
}

class Route {
  final Bounds bounds;
  final String copyrights;
  final List<Leg> legs;

  Route({
    required this.bounds,
    required this.copyrights,
    required this.legs,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      bounds: Bounds.fromJson(json['bounds']),
      copyrights: json['copyrights'],
      legs: (json['legs'] as List).map((e) => Leg.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bounds': bounds.toJson(),
      'copyrights': copyrights,
      'legs': legs.map((e) => e.toJson()).toList(),
    };
  }
}

class Bounds {
  final Location northeast;
  final Location southwest;

  Bounds({
    required this.northeast,
    required this.southwest,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) {
    return Bounds(
      northeast: Location.fromJson(json['northeast']),
      southwest: Location.fromJson(json['southwest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'northeast': northeast.toJson(),
      'southwest': southwest.toJson(),
    };
  }
}

class Leg {
  final Distance distance;
  final Duration duration;
  final String endAddress;
  final Location endLocation;
  final String startAddress;
  final Location startLocation;
  final List<Step> steps;

  Leg({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
    required this.steps,
  });

  factory Leg.fromJson(Map<String, dynamic> json) {
    return Leg(
      distance: Distance.fromJson(json['distance']),
      duration: Duration.fromJson(json['duration']),
      endAddress: json['end_address'],
      endLocation: Location.fromJson(json['end_location']),
      startAddress: json['start_address'],
      startLocation: Location.fromJson(json['start_location']),
      steps: (json['steps'] as List).map((e) => Step.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance.toJson(),
      'duration': duration.toJson(),
      'end_address': endAddress,
      'end_location': endLocation.toJson(),
      'start_address': startAddress,
      'start_location': startLocation.toJson(),
      'steps': steps.map((e) => e.toJson()).toList(),
    };
  }
}

class Distance {
  final String text;
  final int value;

  Distance({
    required this.text,
    required this.value,
  });

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      text: json['text'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'value': value,
    };
  }
}

class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class Step {
  final Distance distance;
  final Duration duration;
  final Location endLocation;
  final String htmlInstructions;
  final Polyline polyline;
  final Location startLocation;
  final String travelMode;

  Step({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.htmlInstructions,
    required this.polyline,
    required this.startLocation,
    required this.travelMode,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      distance: Distance.fromJson(json['distance']),
      duration: Duration.fromJson(json['duration']),
      endLocation: Location.fromJson(json['end_location']),
      htmlInstructions: json['html_instructions'],
      polyline: Polyline.fromJson(json['polyline']),
      startLocation: Location.fromJson(json['start_location']),
      travelMode: json['travel_mode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance.toJson(),
      'duration': duration.toJson(),
      'end_location': endLocation.toJson(),
      'html_instructions': htmlInstructions,
      'polyline': polyline.toJson(),
      'start_location': startLocation.toJson(),
      'travel_mode': travelMode,
    };
  }
}

class Duration {
  final String text;
  final int value;

  Duration({
    required this.text,
    required this.value,
  });

  factory Duration.fromJson(Map<String, dynamic> json) {
    return Duration(
      text: json['text'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'value': value,
    };
  }
}

class Polyline {
  final String points;

  Polyline({required this.points});

  factory Polyline.fromJson(Map<String, dynamic> json) {
    return Polyline(points: json['points']);
  }

  Map<String, dynamic> toJson() {
    return {
      'points': points,
    };
  }
}
