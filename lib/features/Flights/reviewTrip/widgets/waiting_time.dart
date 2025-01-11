import 'package:flutter/material.dart';

class WaitingTime extends StatelessWidget {
  final String duration, location;

  const WaitingTime(
      {super.key, required this.duration, required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.hourglass_empty, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Text('Waiting time: $duration'),
            const Spacer(),
            Text(location, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
