import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RoomsView extends StatelessWidget {
  final String hotelId;
  final String hotelName;
  final String hotelDescription;
  final int hotelRating;
  final String hotelImage;
  final int roomsLength;
  final int adults;
  final String bedType;
  final double price;
  const RoomsView({
    super.key,
    required this.hotelId,
    required this.hotelName,
    required this.hotelDescription,
    required this.hotelRating,
    required this.hotelImage,
    required this.roomsLength,
    this.adults = 2,
    this.bedType = 'King Size',
    this.price = 199.99,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Rooms'.tr),
      ),
      body: ListView.builder(
        itemCount: roomsLength,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            width: .8 * MediaQuery.of(context).size.width,
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
                      child: Image.network(hotelImage),
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
                        hotelName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(hotelDescription),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Row(
                            children: [
                              ...List.generate(
                                  hotelRating,
                                  (index) => const Icon(Icons.star,
                                      size: 16, color: Colors.orange)),
                              const SizedBox(width: 4),
                            ],
                          ),
                          const SizedBox(width: 8),
                           Text(
                            'Very good'.tr,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(' ($hotelRating ratings)'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.bed, color: Colors.red),
                          const SizedBox(width: 8),
                          Text(
                            bedType,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(Icons.person, color: Colors.red),
                              const SizedBox(width: 8),
                              Text(
                                '$adults Adults',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                           Text(
                            'per night',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
