import 'dart:convert';
import 'package:flights/utils/constants/strings.dart';
import 'package:http/http.dart' as http;
import '../models/hotel_offers_model.dart';

class HotelOffersApi {
  Future<HotelOffersModel> getHotelOffers({
    required String hotelId,
    required int adults,
    required String checkInDate,
    required String checkOutDate,
  }) async {
    try {
      final url = Uri.parse(
          '$baseUrl/amadeus/hotels/search-offers?hotelIds=$hotelId&adults=$adults&checkInDate=$checkInDate&checkOutDate=$checkOutDate');

      final response = await http.get(url);
      print("response.body offers hotel: ${response.body}");

      if (response.statusCode == 200) {
        return HotelOffersModel.fromJson(json.decode(response.body));
      } else {
        final errorResponse = json.decode(response.body);
        if (errorResponse['errors'] != null &&
            errorResponse['errors'].isNotEmpty) {
          final error = errorResponse['errors'][0];
          throw Exception('${error['title']}: ${error['detail']}');
        }
        throw Exception('Failed to load hotel offers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting hotel offers: $e');
    }
  }
}
