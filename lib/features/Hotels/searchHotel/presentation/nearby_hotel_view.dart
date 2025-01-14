import 'package:flights/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flights/features/Hotels/searchHotel/domain/nearest_hotels_controller.dart';

class NearByHotelView extends StatelessWidget {
  const NearByHotelView({super.key});

  @override
  Widget build(BuildContext context) {
    final nearestHotelsController = Get.find<NearestHotelsController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.teal,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Damietta El-Gadeeda C...',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, size: 20, color: Colors.grey[600]),
                const SizedBox(width: 2),
                Text('2',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                const SizedBox(width: 5),
                Text(' 12 Jan - 13 Jan',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                const SizedBox(width: 5),
                const Icon(Icons.keyboard_arrow_down,
                    size: 20, color: Colors.grey),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync, color: Colors.teal),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                    width: 60,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.swap_vert_rounded, size: 20)),
                const SizedBox(width: 8),
                Container(
                    width: 60,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.tune, size: 20)),
                const SizedBox(width: 4),
                const SizedBox(width: 8),
                Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Property rating'),
                        Icon(Icons.keyboard_arrow_down,
                            size: 20, color: Colors.teal),
                      ],
                    )),
                const SizedBox(width: 8),
                Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Guest rating'),
                        Icon(Icons.keyboard_arrow_down,
                            size: 20, color: Colors.teal),
                      ],
                    )),
              ],
            ),
          ),

          // Property type chips
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                PropertyTypeChip(
                  icon: Icons.house,
                  label: 'Chalet and Istiraha',
                ),
                SizedBox(width: 8),
                PropertyTypeChip(
                  icon: Icons.apartment,
                  label: 'Apartment',
                ),
                SizedBox(width: 8),
                PropertyTypeChip(
                  icon: Icons.hotel,
                  label: 'Hotel',
                ),
              ],
            ),
          ),

          // Properties count
          const SizedBox(height: 10),
          // Hotel listings
          Expanded(
            child: Obx(() {
              final hotels = nearestHotelsController.hotels?.data.data;
              if (hotels == null || hotels.isEmpty) {
                return const Center(child: Text("No hotels found."));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return FutureBuilder(
                    future: nearestHotelsController.fetchHotelPhotos(
                        baseUrl,
                        hotel.hotelId,
                        hotel.geoCode.latitude,
                        hotel.geoCode.longitude),
                    builder: (context, snapshot) {
                      Widget imageWidget;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        imageWidget =
                            const Center(child: CircularProgressIndicator());
                      } else {
                        imageWidget = Image.network(
                          nearestHotelsController.hotelPhotos!.length > index
                              ? nearestHotelsController.hotelPhotos![index]
                              : 'https://via.placeholder.com/150',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      }
                      return HotelCard(
                        imageWidget: imageWidget,
                        name: hotel.name,
                        location: hotel.address.countryCode,
                        rating: hotel.rating,
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class PropertyTypeChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const PropertyTypeChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

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
