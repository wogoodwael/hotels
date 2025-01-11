import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../utils/constants/strings.dart';
import '../models/offers_model.dart';

class OffersApi {
  Future<OffersModel> getFlightOffers(
      {required String originLocationCode,
      required String destinationLocationCode,
      required String departureDate,
      int? adults = 1,
      String? returnDate,
      int? children,
      int? infants,
      String? travelClass,
      String? includedAirlineCodes,
      String? excludedAirlineCodes,
      bool? nonStop,
      String? currencyCode,
      double? maxPrice,
      int? max}) async {
    final queryParameters = <String, String>{
      'originLocationCode': originLocationCode,
      'destinationLocationCode': destinationLocationCode,
      'departureDate': departureDate,
      'adults': adults.toString(),
      if (returnDate != null) 'returnDate': returnDate,
      if (children != null) 'children': children.toString(),
      if (infants != null) 'infants': infants.toString(),
      if (travelClass != null) 'travelClass': travelClass,
      if (includedAirlineCodes != null)
        'includedAirlineCodes': includedAirlineCodes,
      if (excludedAirlineCodes != null)
        'excludedAirlineCodes': excludedAirlineCodes,
      if (nonStop != null) 'nonStop': nonStop.toString(),
      if (currencyCode != null) 'currencyCode': currencyCode,
      if (maxPrice != null) 'maxPrice': maxPrice.toString(),
      if (max != null) 'max': max.toString(),
    };

    final uri = Uri.parse('$baseUrl/amadeus/flight/offers')
        .replace(queryParameters: queryParameters);

    try {
      final response = await http.get(uri);
      print(response.body);
      if (response.statusCode == 200) {
        final decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        if (decodedResponse['data'] == null) {
          throw Exception('No offers foundttt');
        }

        
        final flightData = decodedResponse['data']['data'];
        if (flightData == null || (flightData as List).isEmpty) {
          return OffersModel.fromJson({
            'data': {
              'meta': {'count': 0, 'links': {}},
              'data': []
            }
          });
        }

        print(response.statusCode);
        print("Traveler Pricing: ${flightData[0]['travelerPricings']}");
        return OffersModel.fromJson(decodedResponse);
      } else {
        print(response.body);
        throw Exception('Failed to load flight offers: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      if (e.toString().contains('_Map<dynamic, dynamic>')) {
        throw Exception('No offers found');
      }
      throw Exception('Failed to load flight offers: $e');
    }
  }
}
