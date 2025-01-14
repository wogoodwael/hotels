import 'dart:convert';
import 'package:flights/utils/constants/strings.dart';
import 'package:http/http.dart' as http;
import '../models/nearset_hotels_model.dart';

class NearestHotelsApi {
  NearestHotelsApi();

  Future<NearestHotelsModel> getNearestHotels({
    required double latitude,
    required double longitude,
    required int radius,
    String radiusUnit = 'KM',
    List<String> amenities = const ['SWIMMING_POOL'],
  }) async {
    try {
      // final queryParams = {
      //   'latitude': latitude.toString(),
      //   'longitude': longitude.toString(),
      //   'radius': radius.toString(),
      //   'radiusUnit': radiusUnit,
      //   'amenities': amenities,
      // };

      final uri = Uri.parse(
          '$baseUrl/amadeus/hotels/list-by-geocode?latitude=41.015137&longitude=28.979530&ratings=[1,2,3,,4,5]'); //must be dynamic

      final response = await http.get(uri);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        return NearestHotelsModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to load nearest hotels: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting nearest hotels: $e');
    }
  }

  Future<NearestHotelsModel> getNearestHotelsWithRadius({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    final url = Uri.parse(
        '$baseUrl/amadeus/hotels/list-by-geocode?latitude=$latitude&longitude=$longitude&radius=$radius');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return NearestHotelsModel.fromJson(data);
    } else {
      throw Exception('Failed to load nearest hotels: ${response.statusCode}');
    }
  }

  Future<List<String>> fetchHotelPhotos(
      String baseUrl, String hotelId, double latitude, double longitude) async {
    final url = Uri.parse('$baseUrl/amadeus/hotels/media');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'hotel_id': hotelId,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      }),
    );
    print("data of photos: ${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("data of photos: $data");
      if (data['success'] && data['state'] == 200) {
        return List<String>.from(data['data']);
      } else {
        throw Exception('Failed to fetch hotel photos: ${data['message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch hotel photos with status code: ${response.statusCode}');
    }
  }
}
