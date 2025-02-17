import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flights/features/Hotels/searchHotel/domain/nearest_hotels_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'search_hotels_page.dart';

class SearchHotelView extends StatefulWidget {
  const SearchHotelView({super.key});

  @override
  State<SearchHotelView> createState() => _SearchHotelViewState();
}

class _SearchHotelViewState extends State<SearchHotelView> {
  final TextEditingController _searchController = TextEditingController();
  final hotelBox = Hive.box('hotelData');
  final nearestHotelsController = Get.find<NearestHotelsController>();
  String currentCity = 'Near me';
  bool showNearbyHotels = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_searchController.text.isNotEmpty) {
          _searchCity(_searchController.text);
        }
      });
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
        radius: 100,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        currentCity = placemarks.first.locality ?? 'Unknown location';
        hotelBox.put('currentCity', currentCity);
        showNearbyHotels = true;
      });
    } catch (e) {
      debugPrint('Error getting current location: $e');
    }
  }

  Future<void> _searchCity(String cityCode) async {
    try {
      setState(() {
        showNearbyHotels = false;
      });

      nearestHotelsController.setLoading(true);

      await nearestHotelsController.searchHotelsByCity(cityCode);

      if (nearestHotelsController.searchResults?.data == null ||
          nearestHotelsController.searchResults!.data.data.isEmpty) {
        debugPrint('No results found for city: $cityCode');
      }
    } catch (e) {
      debugPrint('Error searching city: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching city: ${e.toString()}')),
      );
    } finally {
      nearestHotelsController.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search destination'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: .9 * MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 10),
                hintText: "Where are you going?",
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _searchCity(value);
                }
              },
            ),
          ),
          ListTile(
            leading: Transform.scale(
              scaleX: -1,
              child: const Icon(Icons.near_me_outlined, color: Colors.teal),
            ),
            title: Text(currentCity),
            subtitle: const Text('Near me'),
            onTap: _getCurrentLocation,
          ),
          const Divider(),
          if (!showNearbyHotels) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent searches'),
                  TextButton(
                    onPressed: () {
                      hotelBox.clear();
                    },
                    child: const Text('CLEAR ALL',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (nearestHotelsController.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final searchResults =
                    nearestHotelsController.searchResults?.data;
                if (_searchController.text.isEmpty) {
                  return _buildPopularCities();
                }

                if (searchResults == null || searchResults.data.isEmpty) {
                  return const Center(child: Text("No cities found"));
                }

                return ListView.builder(
                  itemCount: searchResults.data.length,
                  itemBuilder: (context, index) {
                    final city = searchResults.data[index];
                    return ListTile(
                      leading:
                          const Icon(Icons.location_on, color: Colors.grey),
                      title: Text(city.name),
                      subtitle: Text(' ${city.hotelId}'),
                      onTap: () {
                        hotelBox.put('cityName', city.name);
                        hotelBox.put('hotelId', city.hotelId);
                        Get.offAll(() => const SearchHotelsPage());
                      },
                    );
                  },
                );
              }),
            ),
          ] else ...[
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
                    return ListTile(
                      leading: Container(
                          width: 40,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(child: Text(hotel.iataCode))),
                      title: Text(hotel.name),
                      subtitle: Text(hotel.address.countryCode),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          hotel.rating,
                          (index) => const Icon(Icons.star,
                              size: 16, color: Colors.orange),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPopularCities() {
    return ListView(
      children: [
        const ListTile(
          leading: Icon(Icons.history, color: Colors.grey),
          title: Text('Dubai'),
          subtitle: Text('Dubai'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Popular cities ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.grey),
          title: const Text('Dubai'),
          onTap: () => _searchCity('DXB'),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.grey),
          title: const Text('Manama, Bahrain, Bahrain'),
          onTap: () => _searchCity('BAH'),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.grey),
          title: const Text('Cairo, Egypt'),
          onTap: () => _searchCity('CAI'),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.grey),
          title: const Text('Makkah, Western Province, Saudi Arabia'),
          onTap: () => _searchCity('JED'),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.grey),
          title: const Text('Istanbul, Turkey'),
          onTap: () => _searchCity('IST'),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.grey),
          title: const Text('Riyadh, Central Saudi Arabia, Saudi Arabia'),
          onTap: () => _searchCity('RUH'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
