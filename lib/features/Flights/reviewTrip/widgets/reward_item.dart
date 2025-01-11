import 'package:flutter/material.dart';

class RewardItem extends StatelessWidget {
  final String points;

  const RewardItem({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.card_giftcard, color: Colors.blue),
        const SizedBox(width: 8),
        Text(points),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
      ],
    );
  }
}
