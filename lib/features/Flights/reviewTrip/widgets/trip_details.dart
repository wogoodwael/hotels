import 'package:flights/features/Flights/FarTypeSelection/domain/upselling_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'trip_segment.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final UpsellingController upsellingController = Get.find();
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withOpacity(.3))),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
              upsellingController.upsellingResponse.value.data?.data?[0]
                      .itineraries?[0].segments?.length ??
                  0, (int index) {
            return Obx(
              () => TripSegment(
                time: DateFormat.jm().format(DateTime.parse(upsellingController
                        .upsellingResponse
                        .value
                        .data
                        ?.data?[0]
                        .itineraries?[0]
                        .segments?[index]
                        .departure
                        ?.at ??
                    "")),
                location: upsellingController
                        .upsellingResponse
                        .value
                        .data
                        ?.data?[0]
                        .itineraries?[0]
                        .segments?[index]
                        .arrival
                        ?.iataCode ??
                    "",
                terminal: upsellingController
                        .upsellingResponse
                        .value
                        .data
                        ?.data?[0]
                        .itineraries?[0]
                        .segments?[index]
                        .departure
                        ?.terminal ??
                    "",
                duration:
                    "${upsellingController.upsellingResponse.value.data?.data?[0].itineraries?[0].segments?[index].durationData?.hours}h ${upsellingController.upsellingResponse.value.data?.data?[0].itineraries?[0].segments?[index].durationData?.minutes} m"
                    "",
                flight: upsellingController
                        .upsellingResponse
                        .value
                        .data
                        ?.data?[0]
                        .itineraries?[0]
                        .segments?[index]
                        .carrierCode ??
                    "",
                type: '',
                info: upsellingController.upsellingResponse.value.data?.data?[0]
                        .itineraries?[0].segments?[index].departure?.iataCode ??
                    "",
                isCircle: true,
                carrierLogo: upsellingController
                        .upsellingResponse
                        .value
                        .data
                        ?.data?[0]
                        .itineraries?[0]
                        .segments?[index]
                        .carrierLogo ??
                    "",
                carrierCode:
                    "${upsellingController.upsellingResponse.value.data?.data?[0].itineraries?[0].segments?[index].carrierCode} ${upsellingController.upsellingResponse.value.data?.data?[0].itineraries?[0].segments?[index].arrival?.iataCode}",
                height: (upsellingController.upsellingResponse.value.data
                                ?.data?[0].itineraries?[0].segments?.length ??
                            0) ==
                        1
                    ? (upsellingController.upsellingResponse.value.data
                                ?.data?[0].itineraries?[0].segments?.length ??
                            0) *
                        150
                    : (upsellingController.upsellingResponse.value.data
                                ?.data?[0].itineraries?[0].segments?.length ??
                            0) *
                        100,
              ),
            );
          }),
        ),
      ),
    );
  }
}
