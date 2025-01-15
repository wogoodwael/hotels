class SearchCityModel {
  final String message;
  final SearchCityData data;

  SearchCityModel({
    required this.message,
    required this.data,
  });

  factory SearchCityModel.fromJson(Map<String, dynamic> json) {
    return SearchCityModel(
      message: json['message'] ?? '',
      data: SearchCityData.fromJson(json['data']),
    );
  }
}

class SearchCityData {
  final List<HotelData> data;

  SearchCityData({
    required this.data,
  });

  factory SearchCityData.fromJson(Map<String, dynamic> json) {
    return SearchCityData(
      data: (json['data'] as List).map((e) => HotelData.fromJson(e)).toList(),
    );
  }
}

class HotelData {
  final String chainCode;
  final String iataCode;
  final int dupeId;
  final String name;
  final String hotelId;
  final GeoCode geoCode;
  final Address address;
  final int rating;
  final String lastUpdate;
  final dynamic hotellookId;
  final List<String> photos;

  HotelData({
    required this.chainCode,
    required this.iataCode,
    required this.dupeId,
    required this.name,
    required this.hotelId,
    required this.geoCode,
    required this.address,
    required this.rating,
    required this.lastUpdate,
    this.hotellookId,
    required this.photos,
  });

  factory HotelData.fromJson(Map<String, dynamic> json) {
    return HotelData(
      chainCode: json['chainCode'] ?? '',
      iataCode: json['iataCode'] ?? '',
      dupeId: json['dupeId'] ?? 0,
      name: json['name'] ?? '',
      hotelId: json['hotelId'] ?? '',
      geoCode: GeoCode.fromJson(json['geoCode']),
      address: Address.fromJson(json['address']),
      rating: json['rating'] ?? 0,
      lastUpdate: json['lastUpdate'] ?? '',
      hotellookId: json['hotellook_id'],
      photos: List<String>.from(json['photos'] ?? []),
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
