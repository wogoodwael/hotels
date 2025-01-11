import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../utils/constants/strings.dart';
import '../models/nearest_model.dart';

class NearestApi {
  Future<NearestModel> getNearestAirports({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
        '$baseUrl/amadeus/airports/nearest?latitude=51.57285&longitude=-0.44161'); // we must replace by lat and long

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        return NearestModel.fromJson(data);
      } else {
        throw Exception('Failed to load nearest airports');
      }
    } catch (e) {
      throw Exception('Error getting nearest airports: $e');
    }
  }

  Future<NearestModel> getNearestAirportsWithRadius({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    final url = Uri.parse(
        '$baseUrl/amadeus/airports/nearest?latitude=$latitude&longitude=$longitude&radius=$radius');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        return NearestModel.fromJson(data);
      } else {
        throw Exception('Failed to load nearest airports');
      }
    } catch (e) {
      throw Exception('Error getting nearest airports: $e');
    }
  }
}
