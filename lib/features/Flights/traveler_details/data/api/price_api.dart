import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pricing_model.dart';
import '../../../../../utils/constants/strings.dart';

class PriceApi {
  Future<PricingModel> getPrice(Map<String, dynamic> flightOffer) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/amadeus/flight/price?include=other-services'),
        headers: {
         'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'flightOffers': [flightOffer]
        }),
      );

      if (response.statusCode == 200) {
        return PricingModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get pricing: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting pricing: $e');
    }
  }
}
