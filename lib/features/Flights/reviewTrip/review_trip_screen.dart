import 'package:flights/features/Flights/FarTypeSelection/domain/upselling_controller.dart';
import 'package:flights/features/Flights/reviewTrip/widgets/cancel_and_date_change.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../FarTypeSelection/data/api/upselling_api.dart';
import '../FarTypeSelection/data/repo/upselling_repo.dart';
import 'widgets/baggage_allowance.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/earn_rewards.dart';
import 'widgets/trip_details.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ReviewTripScreen extends StatefulWidget {
  const ReviewTripScreen({
    super.key,
    required this.selectedOffer,
    required this.selectedOfferId,
  });
  final Map<String, dynamic> selectedOffer;
  final int selectedOfferId;

  @override
  State<ReviewTripScreen> createState() => _ReviewTripScreenState();
}

class _ReviewTripScreenState extends State<ReviewTripScreen> {
  UpsellingController upsellingController = Get.put(UpsellingController(
      upsellingRepo: UpsellingRepo(upsellingApi: UpsellingApi())));
  @override
  void initState() {
    super.initState();
    fetechData();
  }

  Future fetechData() async {
    await upsellingController.fetchUpsellingData(
        widget.selectedOffer, widget.selectedOfferId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text('Review your trip',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (upsellingController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (upsellingController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Unable to retrieve upsell offer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  upsellingController.errorMessage.value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => fetechData(),
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "from ${upsellingController.upsellingResponse.value.data?.data?[0].source} to ${upsellingController.upsellingResponse.value.data?.data?[0].itineraries?[0].segments?.last.arrival?.iataCode}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      'Total duration',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "${upsellingController.upsellingResponse.value.data?.data?[0].itineraries?[0].durationData?.hours} h ${upsellingController.upsellingResponse.value.data?.data?[0].itineraries?[0].durationData?.minutes}m",
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      DateFormat('dd MMM yyyy  \n hh:mm a').format(
                        DateTime.parse(
                          upsellingController
                                  .upsellingResponse
                                  .value
                                  .data
                                  ?.data?[0]
                                  .itineraries?[0]
                                  .segments
                                  ?.last
                                  .departure
                                  ?.at ??
                              "",
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const TripDetails(),
                const SizedBox(height: 20),
                // Baggage allowance
                BaggageAllowance(),
                const SizedBox(height: 20),
                const CancelAndDateChange(),
                // Earn rewards
                const EarnRewards(),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: BottomBar(flightOffer: widget.selectedOffer),
    );
  }
}
