import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../utils/constants/strings.dart';
import '../domain/offers_controller.dart';
import 'widgets/offers_body.dart';

class FlightBookingScreen extends StatelessWidget {
  FlightBookingScreen({super.key, required this.nonStop});
  final OffersController _offersController = Get.find<OffersController>();
  final bool nonStop;
  @override
  Widget build(BuildContext context) {
    
    final sourceData = Hive.box('flightData').get('source');
    final destinationData = Hive.box('flightData').get('destination');

    final Map<String, dynamic> source =
        sourceData != null ? Map<String, dynamic>.from(sourceData as Map) : {};
    final Map<String, dynamic> destination = destinationData != null
        ? Map<String, dynamic>.from(destinationData as Map)
        : {};

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.teal),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${source['iataCode'] ?? ''} ⇆ ${destination['iataCode'] ?? ''}",
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
            if (_offersController.offers?.data.data != null &&
                _offersController.offers!.data.data.isNotEmpty &&
                _offersController
                    .offers!.data.data[0].travelerPricings.isNotEmpty)
              Text(
                _offersController
                    .offers!.data.data[0].travelerPricings[0].travelerType,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              )
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.teal),
            onPressed: () {
              final departureDate = Hive.box('flightData').get('departureDate');
              print('departureDate: $departureDate');

              final formattedDepartureDate =
                  DateTime.tryParse(departureDate ?? '')
                      ?.toIso8601String()
                      .split('T')
                      .first;
              print('formattedDepartureDate: $formattedDepartureDate');

              final returnDate = Hive.box('flightData').get('returnDate') ?? "";
              print('returnDate: $returnDate');

              String? formattedReturnDate;
              if (returnDate != null && returnDate is String) {
                formattedReturnDate = DateTime.tryParse(returnDate)
                        ?.toIso8601String()
                        .split('T')
                        .first ??
                    "";
              }
              print('formattedReturnDate: $formattedReturnDate');

              final adults = Hive.box('flightData').get('adults');
              print('adults: $adults');

              final children = Hive.box('flightData').get('children');
              print('children: $children');

              final infants = Hive.box('flightData').get('infants');
              print('infants: $infants');

              final cabinClass = Hive.box('flightData').get('cabinClass');
              print('cabinClass: $cabinClass');

              _offersController.getFlightOffers(
                originLocationCode: source['iataCode'] ?? '',
                destinationLocationCode: destination['iataCode'] ?? '',
                departureDate: formattedDepartureDate ?? '',
                returnDate: formattedReturnDate,
                adults: adults ?? 1,
                children: children ?? 0,
                infants: infants ?? 0,
                travelClass: formatTravelClass(cabinClass),
                nonStop: nonStop,
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: OffersBody(offersController: _offersController),
    );
  }
}
