import 'package:flights/features/Flights/FarTypeSelection/domain/upselling_controller.dart';
import 'package:flights/features/Flights/traveler_details/domain/price_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../traveler_details/presentation/traveler_details.dart';

class BottomBar extends StatelessWidget {
  BottomBar({
    super.key,
    required this.flightOffer,
  });
  final priceController = Get.find<PriceController>();
  final UpsellingController upsellingController = Get.find();
  final Map<String, dynamic> flightOffer;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(.4)))),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(
            Icons.keyboard_arrow_up_sharp,
            size: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Obx(
            () => Text(
                "${upsellingController.upsellingResponse.value.data?.data?[0].price?.total ?? ""} ${upsellingController.upsellingResponse.value.data?.data?[0].price?.currency ?? ""}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.teal)),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              print(priceController.pricingModel.value?.data?.data
                  ?.flightOffers?[0].travelerPricings.length);
              priceController.getPrice(flightOffer);
              Get.to(() => TravellerDetailsScreen(
                    flightOffer: flightOffer,
                    travelerId: priceController.pricingModel.value?.data?.data
                            ?.flightOffers?[0].travelerPricings[0].travelerId ??
                        "",
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child:  Text(
              'Continue'.tr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
