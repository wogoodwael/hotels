import 'package:flights/features/Hotels/searchHotel/presentation/nearby_hotel_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../Flights/one_way/presentation/widgets/passenget_section.dart';
import 'search_hotel_view.dart';

class SearchHotelsPage extends StatefulWidget {
  const SearchHotelsPage({super.key});

  @override
  State<SearchHotelsPage> createState() => _SearchHotelsPageState();
}

class _SearchHotelsPageState extends State<SearchHotelsPage> {
  Map<String, dynamic>? locationData;
  bool isCleared = false;
  bool nonStop = false;
  late Box hotelBox;
  DateTime? checkInDate;
  DateTime? checkOutDate;
  String? cityName;
  String? guests;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadHotelData();
  }

  Future<void> _loadHotelData() async {
    try {
      if (!Hive.isBoxOpen('hotelData')) {
        hotelBox = await Hive.openBox('hotelData');
      } else {
        hotelBox = Hive.box('hotelData');
      }

      final savedCityName = hotelBox.get('cityName');
      final savedCheckIn = hotelBox.get('checkInDate');
      final savedCheckOut = hotelBox.get('checkOutDate');
      final savedGuests = hotelBox.get('guests');

      setState(() {
        cityName = savedCityName;
        checkInDate = savedCheckIn != null
            ? DateTime.parse(savedCheckIn)
            : DateTime.now();
        checkOutDate = savedCheckOut != null
            ? DateTime.parse(savedCheckOut)
            : DateTime.now().add(const Duration(days: 1));
        guests = savedGuests ?? '1 Room, 2 Adults, 0 Children';
      });
    } catch (e) {
      debugPrint('Error loading hotel data: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
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
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.location_on_outlined,
                          color: Colors.grey),
                      title: const Text(
                        'Destination',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        cityName ?? 'Select city',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => const SearchHotelView());
                      },
                    ),
                    const Divider(),
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
                                      .format(checkInDate ?? DateTime.now()),
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
                                      checkOutDate ??
                                          DateTime.now()
                                              .add(const Duration(days: 1))),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        final now = DateTime.now();
                        DateTimeRange? dateRange = await showDateRangePicker(
                          context: context,
                          firstDate: now,
                          lastDate: now.add(const Duration(days: 365)),
                          initialDateRange: DateTimeRange(
                            start: checkInDate?.isAfter(now) == true
                                ? checkInDate!
                                : now,
                            end: checkOutDate?.isAfter(now) == true
                                ? checkOutDate!
                                : now.add(const Duration(days: 1)),
                          ),
                        );

                        if (dateRange != null) {
                          setState(() {
                            checkInDate = dateRange.start;
                            checkOutDate = dateRange.end;
                          });

                          hotelBox.put(
                              'checkInDate', dateRange.start.toIso8601String());
                          hotelBox.put(
                              'checkOutDate', dateRange.end.toIso8601String());
                        }
                      },
                    ),
                    const Divider(),
                    const PassengerClassSection(
                      isHotel: true,
                    ),
                    const SizedBox(height: 10),
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
                        onPressed: () async {
                          try {
                            await hotelsOfferController.getHotelOffers(
                              hotelId: Hive.box('hotelData').get('hotelId'),
                              adults: Hive.box('hotelData')
                                  .get('adults', defaultValue: 2),
                              checkInDate: DateFormat('yyyy-MM-dd').format(
                                  DateTime.parse(Hive.box('hotelData').get(
                                      'checkInDate',
                                      defaultValue:
                                          DateTime.now().toIso8601String()))),
                              checkOutDate: DateFormat('yyyy-MM-dd').format(
                                  DateTime.parse(Hive.box('hotelData').get(
                                      'checkOutDate',
                                      defaultValue:
                                          DateTime.now().toIso8601String()))),
                            );

                            Get.to(() => const NearByHotelView(isOffers: true));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error fetching hotel offers'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            debugPrint('Error fetching hotel offers: $e');
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        await _getCurrentLocation();
                        Get.to(() => const NearByHotelView(isOffers: false));
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
