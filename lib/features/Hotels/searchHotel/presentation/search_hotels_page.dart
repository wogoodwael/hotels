import 'package:flights/features/Hotels/searchHotel/presentation/nearby_hotel_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';

class SearchHotelsPage extends StatefulWidget {
  const SearchHotelsPage({super.key});

  @override
  State<SearchHotelsPage> createState() => _SearchHotelsPageState();
}

class _SearchHotelsPageState extends State<SearchHotelsPage> {
  Map<String, dynamic>? locationData;
  bool isCleared = false;
  bool nonStop = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    _loadHotelData();
  }

  Future<void> _loadHotelData() async {
    try {
      if (!Hive.isBoxOpen('hotelData')) {
        await Hive.openBox('hotelData');
      }
      final location = Hive.box('hotelData').get('location') ?? {};
      setState(() {
        locationData = location != null
            ? Map<String, dynamic>.from(location as Map)
            : null;
      });
    } catch (e) {
      debugPrint('Error loading hotel data: $e');
    }
  }

  Future<void> _getCurrentLocationWithRadius(double radius) async {
    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permission denied');
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await nearestHotelsController.getNearestHotelsWithRadius(
        latitude: position.latitude,
        longitude: position.longitude,
        radius: radius.toInt(),
      );
    } catch (e) {
      debugPrint('Error getting current location: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permission denied');
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await nearestHotelsController.getNearestHotels(
        latitude: position.latitude,
        longitude: position.longitude,
        radius: 5,
      );
    } catch (e) {
      debugPrint('Error getting current location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          children: [
            Text(
              'Search stays',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Text(
              'Over 1M properties at your fingertips',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Destination
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading:
                          Icon(Icons.location_on_outlined, color: Colors.grey),
                      title: Text(
                        'Destination',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        'Damietta El-Gadeeda City, Egypt',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Divider(),

                    // Check-in/Check-out Dates
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_today_outlined,
                          color: Colors.grey),
                      title: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Check in',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                Text(
                                  DateFormat('dd MMM, yyyy')
                                      .format(DateTime.now()),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              color: Colors.grey),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Check out',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                Text(
                                  DateFormat('dd MMM, yyyy').format(
                                      DateTime.now()
                                          .add(const Duration(days: 1))),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),

                    // Guests
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.people_outline, color: Colors.grey),
                      title: Text(
                        'Guests',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        '1 Room, 2 Adults, 0 Children',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Search Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.search, color: Colors.white),
                        label: const Text(
                          'Search properties',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Nearby Properties Link
                    InkWell(
                      onTap: () async {
                        await _getCurrentLocation();
                        Get.to(() =>  NearByHotelView());
                      },
                      child: Row(
                        spacing: 10,
                        children: [
                          Transform.scale(
                              scaleX: -1,
                              child: Icon(Icons.near_me_outlined,
                                  color: Colors.teal[400])),
                          const SizedBox(width: 8),
                          const SizedBox(
                            width: 240,
                            child: Text(
                              'Search nearby properties for tonight',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
