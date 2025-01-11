import 'package:flights/features/Flights/traveler_details/presentation/widgets/phone_number_container.dart';
import 'package:flutter/material.dart';

import 'widgets/confirm_bottom_sheet.dart';

class PayUsingPoints extends StatelessWidget {
  const PayUsingPoints({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              children: [
                Text(
                  'Total due',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "SAR 8,611.84",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.withOpacity(.2),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 20),
              child: Text(
                "Enter your phone number registered with Qitaf ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
            ),
            const PhoneNumberContainer()
          ],
        ),
      ),
      bottomSheet: const ConfirmBottomSheet(),
    );
  }
}
