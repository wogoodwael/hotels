import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/upselling_model.dart';

class UpsellingApi {
  final String baseUrl = 'https://iserve-uae.com/wisal_api/public/api';
Future<UpsellingResponse> getUpsellingData(
      Map<String, dynamic> selectedOffer, int offerId) async {
    try {
      
      print("Serialized offer: ${jsonEncode(selectedOffer)}");

      final response = await http.post(
        Uri.parse('$baseUrl/amadeus/flight/upselling'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "data": {
            "type": "flight-offers-upselling",
            "flightOffers": [selectedOffer], 
            "payments": [
              {
                "brand": "VISA_IXARIS",
                "binNumber": 123456,
                "flightOfferIds": [offerId]
              }
            ]
          }
        }),
      );

      if (response.statusCode == 200) {
        return UpsellingResponse.fromJson(jsonDecode(response.body));
      } else {
        print("Error response: ${response.body}");
        throw Exception('Failed to load upselling data');
      }
    } catch (error) {
      print("Error occurred: $error");
      rethrow;
    }
  }

}
