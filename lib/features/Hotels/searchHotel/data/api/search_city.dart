import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flights/utils/constants/strings.dart';
import '../models/search_city_model.dart';

class SearchCityApi {
  SearchCityApi();

  Future<SearchCityModel> searchHotelsByCity({
    required String cityCode,
    int? radius,
    String? radiusUnit,
    List<int> ratings = const [1, 2, 3, 4, 5],
    String lang = 'en',
  }) async {
    try {
/**
 *   final queryParams = {
        'cityCode': cityCode,
        if (radius != null) 'radius': radius.toString(),
        if (radiusUnit != null) 'radiusUnit': radiusUnit,
        'ratings': ratings.toString(),
        'lang': lang,
      };
 * .replace(
        queryParameters: queryParams,
      ); */
      final uri = Uri.parse(
          '$baseUrl/amadeus/hotels/list-by-city?cityCode=$cityCode&radius&radiusUnit&ratings=[5,2]&lang=ar');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return SearchCityModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to search hotels by city: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching hotels by city: $e');
    }
  }
}
