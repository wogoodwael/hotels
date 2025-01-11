import 'package:flutter/material.dart';

class AllowanceItem extends StatelessWidget {
  final String label, pieces;
  final IconData icon;
  final Color color;

  const AllowanceItem(
      {super.key,
      required this.label,
      required this.pieces,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            SizedBox(
                width: 230,
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 15),
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(pieces, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
