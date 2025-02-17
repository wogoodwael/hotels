import 'package:flights/features/Flights/reviewTrip/widgets/reward_item.dart';
import 'package:flutter/material.dart';

class EarnRewards extends StatelessWidget {
  const EarnRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Earn rewards',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text(
              "You can earn one of the following rewards on your booking ",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 15),
            const RewardItem(points: '41210 Mokafaa points'),
            const SizedBox(
              height: 5,
            ),
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            const RewardItem(points: '412 Qitaf points'),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
