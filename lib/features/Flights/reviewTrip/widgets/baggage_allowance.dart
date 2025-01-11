import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../FarTypeSelection/domain/upselling_controller.dart';

class BaggageAllowance extends StatelessWidget {
  BaggageAllowance({super.key});
final UpsellingController upsellingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.grey)),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text('Baggage allowance',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(
                  Icons.info_outline_rounded,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 12),
             ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upsellingController.upsellingResponse.value.data?.data?[0].travelerPricings?[0].fareDetailsBySegment?[0].amenities?.length,
              itemBuilder: (context, index) {
                final amenities = upsellingController
                    .upsellingResponse
                    .value
                    .data
                    ?.data
                    ?.first
                    .travelerPricings
                    ?.first
                    .fareDetailsBySegment
                    ?.first
                    .amenities;

                if (amenities == null || amenities.isEmpty) {
                  return const ListTile(
                    title: Text("No amenities available"),
                  );
                }

                return ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green[200]),
                  title: Text(amenities[index].description ?? "No description"),
                  subtitle: Text(amenities[index].code ?? "No code"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
