import 'dart:convert';

import '../../../../../utils/constants/strings.dart';
import 'package:http/http.dart' as http;

import '../models/nearest_model.dart';
class SearchCityNameApi {
  Future<NearestModel> searchCityName(String keyword) async {
    final url = Uri.parse('$baseUrl/amadeus/locations?keyword=$keyword&subType=CITY,AIRPORT');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
      return NearestModel.fromJson(data);
      } else {
        print(response.body);
        throw Exception('Failed to search locations');
      }
    } catch (e) {
      print(e);
      throw Exception('Error searching locations: $e');
    }
  }
}
