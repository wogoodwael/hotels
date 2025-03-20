import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../FarTypeSelection/data/api/upselling_api.dart';
import '../../../FarTypeSelection/data/repo/upselling_repo.dart';
import '../../../FarTypeSelection/domain/upselling_controller.dart';
import '../../domain/offers_controller.dart';
import '../similar_results_view.dart';
import 'logo_row.dart';
import 'pricing_row.dart';
import 'travel_line_row.dart';

class FlightCardBody extends StatelessWidget {
  const FlightCardBody({
    super.key,
    required this.isBestValue,
    required this.airlineLogo,
    required this.airlineName,
    required this.departureTime,
    required this.stops,
    required this.duration,
    required this.arrivalTime,
    required this.availability,
    required this.price,
    required this.index,
    required this.selectedOfferId,
    required this.showSimilarResults,
  });

  final bool isBestValue;
  final String airlineLogo;
  final String airlineName;
  final String departureTime;
  final String stops;
  final String duration;
  final String arrivalTime;
  final String availability;
  final String price;
  final int index;
  final int selectedOfferId;
  final bool showSimilarResults;
  @override
  Widget build(BuildContext context) {
    final OffersController offersController = Get.find();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.withOpacity(.5))),
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBestValue)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(5),
                ),
                child:  Text(
                  "Best Value".tr,
                  style: TextStyle(color: Colors.green),
                ),
              ),
            const SizedBox(height: 8),
            LogoRow(airlineLogo: airlineLogo, airlineName: airlineName),
            const SizedBox(height: 16),
            TravelLineRow(
                departureTime: departureTime,
                stops: stops,
                duration: duration,
                arrivalTime: arrivalTime),
            Divider(
              color: Colors.grey.withOpacity(.3),
            ),
            PricingRow(availability: availability, price: price),
            const SizedBox(height: 16),
            if (showSimilarResults)
              GestureDetector(
                onTap: () async {
                  try {
                    final selectedOffer =
                        offersController.offers!.data.data[index].toJson();
                    final UpsellingController upsellingController = Get.put(
                        UpsellingController(
                            upsellingRepo:
                                UpsellingRepo(upsellingApi: UpsellingApi())));
                    Get.dialog(
                      name: "loading",
                      const Center(
                          child: CircularProgressIndicator(
                        color: Colors.teal,
                      )),
                      barrierDismissible: false,
                    );

                    await upsellingController.fetchUpsellingData(
                        selectedOffer, selectedOfferId);
                    Get.back();

                    Get.to(() => const SimilarResultsView());
                    print("Show similar results with upselling data");
                  } catch (e, stackTrace) {
                    Get.back();
                    print("Error while fetching upselling data: $e");
                    print("Stacktrace: $stackTrace");
                    if (e
                        .toString()
                        .contains("UNABLE TO RETRIEVE UPSELL OFFER")) {
                      Get.snackbar("Error", "No upsell offer can be found");
                    } else {
                      Get.snackbar(
                          "Error", "Failed to fetch upselling data: $e");
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.teal.withOpacity(.1),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child:  Center(
                    child: Text(
                      "Search For Similar Results ".tr,
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
