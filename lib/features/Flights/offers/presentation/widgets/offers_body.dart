import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/offers_controller.dart';
import 'flight_card.dart';

class OffersBody extends StatelessWidget {
  const OffersBody({
    super.key,
    required this.offersController,
  });

  final OffersController offersController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 180,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.4)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.swap_vert_rounded, size: 20),
                      SizedBox(width: 8),
                      Text("Sort: Recommended"),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.4)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_list, size: 20),
                      SizedBox(width: 8),
                      Text("Filters"),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.4)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.stop, size: 20),
                      SizedBox(width: 8),
                      Text("Stops"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            if (offersController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (offersController.error.isNotEmpty) {
              return const Center(child: Text("No offers available"));
            }

            if (offersController.offers == null) {
              return const Center(child: Text('No offers available'));
            }

            return ListView.builder(
              itemCount: offersController.offers!.data.data.length,
              itemBuilder: (context, index) {
                final offer = offersController.offers!.data.data[index];
                print('Offer $index:');
                print('Airline codes: ${offer.validatingAirlineCodes}');
                print(
                    'Departure time: ${offer.itineraries.first.segments.first.departure.at}');
                print(
                    'Arrival time: ${offer.itineraries.first.segments.last.arrival.at}');
                print('Duration: ${offer.itineraries.first.duration}');
                print(
                    'Segments length: ${offer.itineraries.first.segments.length}');
                print('Currency: ${offer.price.currency}');
                print('Total price: ${offer.price.total}');
                return FlightCard(
                  airlineLogo: offer.itineraries[0].segments[0].carrierLogo,
                  airlineName: offer.validatingAirlineCodes.first,
                  departureTime:
                      offer.itineraries.first.segments.first.departure.at,
                  arrivalTime: offer.itineraries.first.segments.last.arrival.at,
                  duration:
                      "${offer.itineraries.first.durationData.hours} hr${offer.itineraries.first.durationData.minutes} min",
                  stops: offer.itineraries.first.segments.length > 1
                      ? "${offer.itineraries.first.segments.length - 1} stop(s)"
                      : "Direct",
                  price: "${offer.price.currency} ${offer.price.total}",
                  availability: offer.numberOfBookableSeats.toString() ?? "",
                  isBestValue: index == 0,
                  selectedOfferId: int.parse(offer.id),
                  selectedFlightOffer: {
                    "type": "flight-offer",
                    "id": offer.id,
                    "source": offer.source,
                    "instantTicketingRequired": false,
                    "nonHomogeneous": false,
                    "oneWay": false,
                    "isUpsellOffer": false,
                    "lastTicketingDate": offer.lastTicketingDate,
                    "lastTicketingDateTime": offer.lastTicketingDateTime,
                    "numberOfBookableSeats": 9,
                    "itineraries": offer.itineraries,
                    "price": offer.price,
                    "pricingOptions": offer.pricingOptions,
                    "validatingAirlineCodes": offer.validatingAirlineCodes,
                    "travelerPricings": offer.travelerPricings
                  },
                  index: index,
                  showSimilarResults: true,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
