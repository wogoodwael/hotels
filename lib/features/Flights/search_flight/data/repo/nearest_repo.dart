import '../api/nearest_api.dart';
import '../models/nearest_model.dart';

class NearestRepo {
  final NearestApi nearestApi;

  NearestRepo({required this.nearestApi});

  Future<NearestModel> getNearestAirports({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final result = await nearestApi.getNearestAirports(
        latitude: latitude,
        longitude: longitude,
      );
      return result;
    } catch (e) {
      throw Exception('Repository Error: $e');
    }
  }

  Future<NearestModel> getNearestAirportsWithRadius({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    try {
      final result = await nearestApi.getNearestAirportsWithRadius(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      return result;
    } catch (e) {
      throw Exception('Repository Error: $e');
    }
  }
}
