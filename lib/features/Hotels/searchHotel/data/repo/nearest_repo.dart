import '../api/nearest_hotels_api.dart';
import '../models/nearset_hotels_model.dart';

class NearestHotelsRepo {
  final NearestHotelsApi nearestHotelsApi;

  NearestHotelsRepo({required this.nearestHotelsApi});

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
}
