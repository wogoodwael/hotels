import 'package:flights/features/Flights/payments/presentation/select_payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//need to refactor
class UpgradeExperienceScreen extends StatelessWidget {
  const UpgradeExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Upgrade your experience",
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const ListTile(
              title: Text(
                'Total to be paid ',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              subtitle: Text(
                "SAR 8,611.84",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              trailing: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "VIEW BOOKING SUMMARY",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "new",
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      SizedBox(width: 5),
                      SizedBox(
                        width: 300,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Baggage Protection",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Enjoy priority baggage protection\n- Guaranteed recovery within 96 hours\n- Get compensated up to SAR 4,000",
                                  style: TextStyle(
                                      height: 3,
                                      color: Colors.grey,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.luggage, color: Colors.teal, size: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(.3),
                  ),
                  Row(
                    children: [
                      const Text(
                        "SAR 20",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        label: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.add_circle_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Divider(
              color: Colors.grey.withOpacity(.2),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => SelectPaymentMethodScreen());
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Skip & continue to payment",
                style: TextStyle(color: Colors.teal, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
