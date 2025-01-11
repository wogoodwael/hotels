import 'package:flights/features/Flights/search_flight/data/repo/nearest_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../data/api/nearest_api.dart';
import '../data/api/search_city_name.dart';
import '../data/repo/search_city_name_repo.dart';
import '../domain/nearest_controller.dart';
import '../domain/search_city_name_controller.dart';
import 'widgets/get_nearest_airports.dart';

class SearchFlightView extends StatefulWidget {
  const SearchFlightView({super.key, required this.isdestination});
  final bool isdestination;
  @override
  State<SearchFlightView> createState() => _SearchFlightViewState();
}

class _SearchFlightViewState extends State<SearchFlightView> {
  final TextEditingController _searchController = TextEditingController();
  final NearestController _nearestController = Get.put(
    NearestController(nearestRepo: NearestRepo(nearestApi: NearestApi())),
  );
  final SearchCityNameController _searchCityNameController = Get.put(
    SearchCityNameController(
      searchCityNameRepo:
          SearchCityNameRepo(searchCityNameApi: SearchCityNameApi()),
    ),
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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

      await _nearestController.getNearestAirportsWithRadius(
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

      await _nearestController.getNearestAirports(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      debugPrint('Error getting current location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Flight')),
      body: GetNearestAirports(
        context,
        _searchController,
        _searchCityNameController,
        _nearestController,
        _getCurrentLocationWithRadius,
        100, // Default radius of 100km
        widget.isdestination,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
