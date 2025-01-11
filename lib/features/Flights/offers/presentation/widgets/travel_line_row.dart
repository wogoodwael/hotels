import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TravelLineRow extends StatelessWidget {
  const TravelLineRow({
    super.key,
    required this.departureTime,
    required this.stops,
    required this.duration,
    required this.arrivalTime,
  });

  final String departureTime;
  final String stops;
  final String duration;
  final String arrivalTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(DateFormat('hh:mm a').format(DateTime.parse(departureTime)),
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            const Text("AUH", style: TextStyle(color: Colors.grey)),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                  child: Divider(),
                ),
                Text(stops, style: const TextStyle(color: Colors.green)),
                const SizedBox(
                  width: 20,
                  child: Divider(),
                ),
                const Icon(
                  Icons.flight,
                  size: 15,
                  color: Colors.grey,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(duration, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        Column(
          children: [
            Text(DateFormat('hh:mm a').format(DateTime.parse(arrivalTime)),
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            const Text("JED", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
