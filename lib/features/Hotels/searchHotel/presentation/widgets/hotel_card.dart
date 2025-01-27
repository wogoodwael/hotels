import 'package:flutter/material.dart';

class HotelCard extends StatelessWidget {
  final Widget imageWidget;
  final String name;
  final String location;
  final int rating;

  const HotelCard({
    super.key,
    required this.imageWidget,
    required this.name,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: .9 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: imageWidget,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(' star property'),
                    const Text(' • '),
                    Text(location),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: [
                        ...List.generate(
                            rating,
                            (index) => const Icon(Icons.star,
                                size: 16, color: Colors.orange)),
                        const SizedBox(width: 4),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Very good',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(' ($rating ratings)'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
