import 'package:flights/features/Flights/FarTypeSelection/data/api/upselling_api.dart';
import 'package:flights/features/Flights/FarTypeSelection/domain/upselling_controller.dart';
import 'package:flights/features/Flights/FarTypeSelection/far_type_selection_view.dart';
import 'package:flights/features/Flights/offers/presentation/widgets/flight_card_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flights/features/Flights/FarTypeSelection/data/repo/upselling_repo.dart';
import '../../domain/offers_controller.dart';
import '../../../reviewTrip/review_trip_screen.dart';

class FlightCard extends StatelessWidget {
  final String airlineLogo;
  final String airlineName;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String stops;
  final String price;
  final String availability;
  final bool isBestValue;
  final int selectedOfferId;
  final Map<String, dynamic> selectedFlightOffer;
  final int index;
  final bool showSimilarResults;

  const FlightCard(
      {super.key,
      required this.airlineLogo,
      required this.airlineName,
      required this.departureTime,
      required this.arrivalTime,
      required this.duration,
      required this.stops,
      required this.price,
      this.availability = "",
      this.isBestValue = false,
      required this.selectedOfferId,
      required this.selectedFlightOffer,
      required this.index,
      required this.showSimilarResults});

  @override
  Widget build(BuildContext context) {
    print('Building FlightCard:');
    print('airlineName: $airlineName');
    print('departureTime: $departureTime');
    print('arrivalTime: $arrivalTime');
    print('duration: $duration');
    print('stops: $stops');
    print('price: $price');
    print('availability: $availability');
    final OffersController offersController = Get.find();
    final selectedOffer = offersController.offers!.data.data[index].toJson();
    return GestureDetector(
      onTap: () {
        Get.to(() => ReviewTripScreen(
            selectedOffer: selectedOffer, selectedOfferId: selectedOfferId));
      },
      child: FlightCardBody(
        index: index,
        selectedOfferId: selectedOfferId,
        isBestValue: isBestValue,
        airlineLogo: airlineLogo,
        airlineName: airlineName,
        departureTime: departureTime,
        stops: stops,
        duration: duration,
        arrivalTime: arrivalTime,
        availability: availability,
        price: price,
        showSimilarResults: showSimilarResults,
      ),
    );
  }
}
