import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/helper/snack_bar.dart';

class OrderApi {
  Future<Map<String, dynamic>> postOrder({
    required Map<String, dynamic> flightOffer,
    required List<Map<String, dynamic>> travelers,
    required List<Map<String, dynamic>> contacts,
    required Map<String, dynamic> ticketingAgreement,
    required Map<String, dynamic> bookingRequirements,
  }) async {
    try {
      final requestBody = {
        'offer': flightOffer,
        'travelers': travelers,
        'contacts': contacts,
        'bookingRequirements': bookingRequirements,
      };

      log('Full request body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse('$baseUrl/amadeus/flight/order'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        showSuccessSnackBar(' ${jsonDecode(response.body)['message']}',
            'Order created successfully');
        return jsonDecode(response.body);
      } else {
        showErrorSnackBar(' ${jsonDecode(response.body)['message']}',
            'Failed to create order');
        throw Exception('Failed to create order: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating order: $e');
    }
  }
}
