import 'package:flights/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flights/features/Hotels/searchHotel/domain/nearest_hotels_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../hotelsOffers/domain/hotels_offer_controller.dart';

class NearByHotelView extends StatefulWidget {
  const NearByHotelView({super.key, required this.isOffers});
  final bool isOffers;

  @override
  State<NearByHotelView> createState() => _NearByHotelViewState();
}

class _NearByHotelViewState extends State<NearByHotelView> {
  String locationName = 'Unknown location';
  final nearestHotelsController = Get.find<NearestHotelsController>();
  DateTime? checkInDate;
  DateTime? checkOutDate;
  final hotelsOfferController = Get.find<HotelsOfferController>();

  @override
  void initState() {
    super.initState();
   
    if (widget.isOffers) {
      _getOffers();
    } else {
     _getLocationName(); 
    }
    
    String? checkInString =
        Hive.box('hotelData').get('checkInDate', defaultValue: null);
    String? checkOutString =
        Hive.box('hotelData').get('checkOutDate', defaultValue: null);

    if (checkInString != null) {
      checkInDate = DateTime.parse(checkInString);
    }
    if (checkOutString != null) {
      checkOutDate = DateTime.parse(checkOutString);
    }
  }

  Future<void> _getNearbyHotels() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await nearestHotelsController.getNearestHotels(
        latitude: position.latitude,
        longitude: position.longitude,
        radius: 100,
      );
    } catch (e) {
      debugPrint('Error getting nearby hotels: $e');
    }
  }

  Future<void> _getLocationName() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        locationName = placemarks.first.locality ?? 'loading... location';
      });
    } catch (e) {
      debugPrint('Error getting current location: $e');
    }
  }

  Future<void> _getOffers() async {
    await hotelsOfferController.getHotelOffers(
      hotelId: Hive.box('hotelData').get('hotelId',
          defaultValue:
              nearestHotelsController.hotels?.data.data.first.hotelId),
      adults: Hive.box('hotelData').get('adults', defaultValue: 2),
      checkInDate: Hive.box('hotelData').get('checkInDate', defaultValue: ''),
      checkOutDate: Hive.box('hotelData').get('checkOutDate', defaultValue: ''),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              widget.isOffers
                  ? Hive.box('hotelData')
                      .get('cityName', defaultValue: locationName)
                  : locationName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      print("city$locationName");
                    },
                    child: Icon(Icons.person_outline,
                        size: 20, color: Colors.grey[600])),
                const SizedBox(width: 2),
                Text(
                    Hive.box('hotelData')
                        .get('adults', defaultValue: 2)
                        .toString(),
                    style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                const SizedBox(width: 5),
                Text(
                    '${DateFormat('dd MMM').format(checkInDate ?? DateTime.now())} - ${DateFormat('dd MMM').format(checkOutDate ?? DateTime.now())}',
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

          
          const SizedBox(height: 10),
          
          Expanded(
            child: Obx(() {
              if (widget.isOffers) {
                final hotelsOffers =
                    hotelsOfferController.hotelOffers.value?.data.data;
                if (hotelsOffers == null || hotelsOffers.isEmpty) {
                  return const Center(child: Text("No hotel offers found."));
                }
                return _buildHotelList(hotelsOffers.length,
                    hotelsOffers: hotelsOffers);
              } else {
                final hotels = nearestHotelsController.hotels?.data.data;
                if (hotels == null || hotels.isEmpty) {
                  return const Center(child: Text("No hotels found."));
                }
                return _buildHotelList(hotels.length, hotels: hotels);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelList(int itemCount, {var hotels, var hotelsOffers}) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final hotelData =
            widget.isOffers ? hotelsOffers[index].hotel : hotels[index];
        return FutureBuilder(
          future: nearestHotelsController.fetchHotelPhotos(
            baseUrl,
            hotelData.hotelId,
            widget.isOffers ? hotelData.latitude : hotelData.geoCode.latitude,
            widget.isOffers ? hotelData.longitude : hotelData.geoCode.longitude,
          ),
          builder: (context, snapshot) {
            Widget imageWidget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              imageWidget = const Center(child: CircularProgressIndicator());
            } else {
              imageWidget = Image.network(
                nearestHotelsController.hotelPhotos != null &&
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
              name: hotelData.name,
              location: widget.isOffers
                  ? hotelData.type
                  : hotelData.address.countryCode,
              rating: widget.isOffers ? 5 : hotelData.rating,
            );
          },
        );
      },
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
