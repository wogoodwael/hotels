import 'package:flutter/material.dart';

class LogoRow extends StatelessWidget {
  const LogoRow({
    super.key,
    required this.airlineLogo,
    required this.airlineName,
  });

  final String airlineLogo;
  final String airlineName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(airlineLogo, width: 40),
        const SizedBox(width: 10),
        Text(
          airlineName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const Icon(
          Icons.directions_bus_rounded,
          color: Colors.grey,
        )
      ],
    );
  }
}
