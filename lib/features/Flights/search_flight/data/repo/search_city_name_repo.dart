import 'package:flights/features/Flights/search_flight/data/models/nearest_model.dart';

import '../api/search_city_name.dart';

class SearchCityNameRepo {
  final SearchCityNameApi searchCityNameApi;

  SearchCityNameRepo({required this.searchCityNameApi});

  Future<NearestModel> searchCityName(String keyword) async {
    try {
      final result = await searchCityNameApi.searchCityName(keyword);
      return result;
    } catch (e) {
      throw Exception('Repository Error: $e');
    }
  }
}
