class NearestModel {
  final String message;
  final NearestData data;
  final List<dynamic> errors;
  final int state;
  final bool success;

  NearestModel({
    required this.message,
    required this.data,
    required this.errors,
    required this.state,
    required this.success,
  });

  factory NearestModel.fromJson(Map<String, dynamic> json) {
    return NearestModel(
      message: json['message'] ?? '',
      data: NearestData.fromJson(json['data'] ?? {}),
      errors: json['errors'] ?? [],
      state: json['state'] ?? 0,
      success: json['success'] ?? false,
    );
  }
}

class NearestData {
  final Meta meta;
  final List<Airport> data;

  NearestData({
    required this.meta,
    required this.data,
  });

  factory NearestData.fromJson(Map<String, dynamic> json) {
    return NearestData(
      meta: Meta.fromJson(json['meta'] ?? {}),
      data: (json['data'] as List? ?? [])
          .map((x) => Airport.fromJson(x ?? {}))
          .toList(),
    );
  }
}

class Meta {
  final int count;
  final Links links;

  Meta({
    required this.count,
    required this.links,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      count: json['count'] ?? 0,
      links: Links.fromJson(json['links'] ?? {}),
    );
  }
}

class Links {
  final String self;
  final String next;
  final String last;

  Links({
    required this.self,
    required this.next,
    required this.last,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json['self'] ?? '',
      next: json['next'] ?? '',
      last: json['last'] ?? '',
    );
  }
}

class Airport {
  final String type;
  final String subType;
  final String name;
  final String detailedName;
  final String timeZoneOffset;
  final String iataCode;
  final GeoCode geoCode;
  final Address address;
  final Distance distance;
  final Analytics analytics;
  final double relevance;

  Airport({
    required this.type,
    required this.subType,
    required this.name,
    required this.detailedName,
    required this.timeZoneOffset,
    required this.iataCode,
    required this.geoCode,
    required this.address,
    required this.distance,
    required this.analytics,
    required this.relevance,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      type: json['type'] ?? '',
      subType: json['subType'] ?? '',
      name: json['name'] ?? '',
      detailedName: json['detailedName'] ?? '',
      timeZoneOffset: json['timeZoneOffset'] ?? '',
      iataCode: json['iataCode'] ?? '',
      geoCode: GeoCode.fromJson(json['geoCode'] ?? {}),
      address: Address.fromJson(json['address'] ?? {}),
      distance: Distance.fromJson(json['distance'] ?? {}),
      analytics: Analytics.fromJson(json['analytics'] ?? {}),
      relevance: json['relevance']?.toDouble() ?? 0.0,
    );
  }
}

class GeoCode {
  final double latitude;
  final double longitude;

  GeoCode({
    required this.latitude,
    required this.longitude,
  });

  factory GeoCode.fromJson(Map<String, dynamic> json) {
    return GeoCode(
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }
}

class Address {
  final String cityName;
  final String cityCode;
  final String countryName;
  final String countryCode;
  final String regionCode;

  Address({
    required this.cityName,
    required this.cityCode,
    required this.countryName,
    required this.countryCode,
    required this.regionCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      cityName: json['cityName'] ?? '',
      cityCode: json['cityCode'] ?? '',
      countryName: json['countryName'] ?? '',
      countryCode: json['countryCode'] ?? '',
      regionCode: json['regionCode'] ?? '',
    );
  }
}

class Distance {
  final int value;
  final String unit;

  Distance({
    required this.value,
    required this.unit,
  });

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      value: json['value'] ?? 0,
      unit: json['unit'] ?? '',
    );
  }
}

class Analytics {
  final Score flights;
  final Score travelers;

  Analytics({
    required this.flights,
    required this.travelers,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) {
    return Analytics(
      flights: Score.fromJson(json['flights'] ?? {}),
      travelers: Score.fromJson(json['travelers'] ?? {}),
    );
  }
}

class Score {
  final int score;

  Score({
    required this.score,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      score: json['score'] ?? 0,
    );
  }
}
