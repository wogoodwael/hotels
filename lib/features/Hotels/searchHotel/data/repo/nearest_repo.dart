import '../api/nearest_hotels_api.dart';
import '../api/search_city.dart';
import '../models/nearset_hotels_model.dart';
import '../models/search_city_model.dart';

class NearestHotelsRepo {
  final NearestHotelsApi nearestHotelsApi;
  final SearchCityApi searchCityApi;

  NearestHotelsRepo({
    required this.nearestHotelsApi,
    required this.searchCityApi,
  });

  Future<NearestHotelsModel> getNearestHotels({
    required double latitude,
    required double longitude,
    required int radius,
    String radiusUnit = 'KM',
    List<String> amenities = const ['SWIMMING_POOL'],
  }) async {
    try {
      final result = await nearestHotelsApi.getNearestHotels(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
        radiusUnit: radiusUnit,
        amenities: amenities,
      );
      return result;
    } catch (e) {
      throw Exception('Repository Error: $e');
    }
  }

  Future<NearestHotelsModel> getNearestHotelsWithRadius({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    try {
      final result = await nearestHotelsApi.getNearestHotelsWithRadius(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      return result;
    } catch (e) {
      throw Exception('Repository Error: $e');
    }
  }

  Future<List<String>> fetchHotelPhotos({
    required String baseUrl,
    required String hotelId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final photos = await nearestHotelsApi.fetchHotelPhotos(
        baseUrl,
        hotelId,
        latitude,
        longitude,
      );
      return photos;
    } catch (e) {
      throw Exception('Repository Error: $e');
    }
  }

  Future<SearchCityModel> searchHotelsByCity({
    required String cityCode,
  }) async {
    final result = await searchCityApi.searchHotelsByCity(cityCode: cityCode);
    return result;
  }
}
