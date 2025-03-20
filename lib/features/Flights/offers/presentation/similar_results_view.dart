import 'package:flights/features/Flights/offers/presentation/widgets/flight_card_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flights/features/Flights/FarTypeSelection/domain/upselling_controller.dart';

import '../../reviewTrip/review_trip_screen.dart';

class SimilarResultsView extends StatefulWidget {
  const SimilarResultsView({super.key});

  @override
  State<SimilarResultsView> createState() => _SimilarResultsViewState();
}

class _SimilarResultsViewState extends State<SimilarResultsView> {
  late UpsellingController upsellingController;
  bool isLoading = true;
  dynamic upsellingData;

  @override
  void initState() {
    super.initState();
    upsellingController = Get.find();
    _fetchUpsellingData();
  }

  void _fetchUpsellingData() {
    setState(() {
      isLoading = true;
    });

    // Use a slight delay to ensure the state is updated
    Future.delayed(Duration.zero, () {
      final response = upsellingController.upsellingResponse.value;
      setState(() {
        upsellingData = response.data;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text('Similar Results'.tr),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : upsellingData?.data == null || upsellingData!.data!.isEmpty
              ?  Center(child: Text('No similar results available'.tr))
              : ListView.builder(
                  itemCount: upsellingData.data!.length,
                  itemBuilder: (context, index) {
                    final offer = upsellingData.data![index];
                    return GestureDetector(
                      onTap: () async {
                        print("${offer.travelerPricings?.length}offers length");
                        Get.to(() => ReviewTripScreen(
                            selectedOffer: offer.toJson(),
                            selectedOfferId: int.parse(offer.id ?? "")));
                      },
                      child: FlightCardBody(
                        airlineLogo:
                            offer.itineraries?[0].segments?[0].carrierLogo ??
                                "",
                        airlineName: offer.validatingAirlineCodes?.first ?? "",
                        departureTime:
                            offer.itineraries?[0].segments?[0].departure?.at ??
                                "",
                        arrivalTime:
                            offer.itineraries?[0].segments?[0].arrival?.at ??
                                "",
                        duration:
                            "${offer.itineraries?[0].durationData?.hours} hr ${offer.itineraries?[0].durationData?.minutes} min",
                        stops: (offer.itineraries?[0].segments?.length ?? 0) > 1
                            ? "${(offer.itineraries?[0].segments?.length ?? 0) - 1} stop(s)"
                            : "Direct",
                        price: "${offer.price?.currency} ${offer.price?.total}",
                        availability: offer.travelerPricings?[0]
                                .fareDetailsBySegment?[0].className ??
                            "",
                        isBestValue: false,
                        selectedOfferId: int.parse(offer.id ?? ""),
                        index: index,
                        showSimilarResults: false,
                      ),
                    );
                  },
                ),
    );
  }
}
