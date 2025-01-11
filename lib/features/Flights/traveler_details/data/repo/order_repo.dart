import '../api/order_api.dart';

class OrderRepo {
  final OrderApi orderApi;

  OrderRepo({required this.orderApi});

  Future<Map<String, dynamic>> createOrder({
    required Map<String, dynamic> flightOffer,
    required List<Map<String, dynamic>> travelers,
    required List<Map<String, dynamic>> contacts,
    required Map<String, dynamic> ticketingAgreement,
    required Map<String, dynamic> bookingRequirements,
  }) async {
    try {
        final response = await orderApi.postOrder(
        flightOffer: flightOffer,
        travelers: travelers,
        contacts: contacts,
        ticketingAgreement: ticketingAgreement,
        bookingRequirements: bookingRequirements,
      );
      return response;
    } catch (e) {
      throw Exception('Repository error creating order: $e');
    }
  }
}
