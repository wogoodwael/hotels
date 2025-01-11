import 'package:flutter/material.dart';

class PricingRow extends StatelessWidget {
  const PricingRow({
    super.key,
    required this.availability,
    required this.price,
  });

  final String availability;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 170,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (availability.isNotEmpty)
                Text(
                  "$availability  Seats left at this price ",
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              const Icon(
                Icons.local_fire_department_outlined,
                color: Colors.red,
                size: 15,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 25,
                decoration: const BoxDecoration(color: Colors.teal),
                child: const Center(
                  child: Text(
                    "Starting from",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                " $price",
                style: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )
            ],
          ),
        ),
      ],
    );
  }
}
