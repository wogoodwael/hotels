import 'package:flights/features/Flights/traveler_details/scan_id_functionality.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/add_manually.dart';

class ScanIDScreen extends StatelessWidget {
  final int travelerIndex;

  const ScanIDScreen({super.key, required this.travelerIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 300,
                  color: Colors.grey.shade200,
                ),
                const Column(
                  children: [
                    Icon(
                      Icons.document_scanner,
                      size: 100,
                      color: Colors.teal,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Scan traveller ID',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Use your passport or GCC National ID to quickly and securely auto-fill traveller details.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.teal),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Make sure to scan the side with the ID code displayed (shown above).",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.camera_alt_outlined, color: Colors.teal),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "We'll need access to your camera to be able to scan the document.",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.shield_outlined, color: Colors.teal),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Your information is secure, and your ID image will not be saved.",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Get.to(() => ScanIDFunctionality());
                      },
                      icon: const Icon(
                        Icons.document_scanner_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Scan ID ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        minimumSize: const Size(300, 50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() => AddManuallyScreen(travelerIndex: travelerIndex));
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.teal,
                      ),
                      label: const Text(
                        "Add manually",
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(300, 50),
                          side: const BorderSide(color: Colors.teal)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
