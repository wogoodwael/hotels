class NearestHotelsModel {
  final String message;
  final NearestHotelsData data;
  final List<dynamic> errors;
  final int state;
  final bool success;

  NearestHotelsModel({
    required this.message,
    required this.data,
    required this.errors,
    required this.state,
    required this.success,
  });

  factory NearestHotelsModel.fromJson(Map<String, dynamic> json) {
    return NearestHotelsModel(
      message: json['message'] ?? '',
      data: NearestHotelsData.fromJson(json['data'] ?? {}),
      errors: json['errors'] ?? [],
      state: json['state'] ?? 0,
      success: json['success'] ?? false,
    );
  }
}

class NearestHotelsData {
  final List<Hotel> data;

  NearestHotelsData({
    required this.data,
  });

  factory NearestHotelsData.fromJson(Map<String, dynamic> json) {
    return NearestHotelsData(
      data: (json['data'] as List? ?? [])
          .map((x) => Hotel.fromJson(x ?? {}))
          .toList(),
    );
  }
}

class Hotel {
  final String chainCode;
  final String iataCode;
  final int dupeId;
  final String name;
  final String hotelId;
  final GeoCode geoCode;
  final Address address;
  final Distance distance;
  final String lastUpdate;
  final int rating;
  final dynamic hotellookId;
  final List<dynamic> photos;

  Hotel({
    required this.chainCode,
    required this.iataCode,
    required this.dupeId,
    required this.name,
    required this.hotelId,
    required this.geoCode,
    required this.address,
    required this.distance,
    required this.lastUpdate,
    required this.rating,
    required this.hotellookId,
    required this.photos,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      chainCode: json['chainCode'] ?? '',
      iataCode: json['iataCode'] ?? '',
      dupeId: json['dupeId'] ?? 0,
      name: json['name'] ?? '',
      hotelId: json['hotelId'] ?? '',
      geoCode: GeoCode.fromJson(json['geoCode'] ?? {}),
      address: Address.fromJson(json['address'] ?? {}),
      distance: Distance.fromJson(json['distance'] ?? {}),
      lastUpdate: json['lastUpdate'] ?? '',
      hotellookId: json['hotellook_id'],
      photos: json['photos'] ?? [],
      rating: json['rating'] ?? 0,
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
  final String countryCode;

  Address({
    required this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      countryCode: json['countryCode'] ?? '',
    );
  }
}

class Distance {
  final double value;
  final String unit;

  Distance({
    required this.value,
    required this.unit,
  });

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      value: json['value']?.toDouble() ?? 0.0,
      unit: json['unit'] ?? '',
    );
  }
}
