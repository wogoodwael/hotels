import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

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
  final nearestController = Get.find<NearestController>();
  final searchCityNameController = Get.find<SearchCityNameController>();

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

      await nearestController.getNearestAirportsWithRadius(
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

      await nearestController.getNearestAirports(
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
      appBar: AppBar(title: 
       Text('Search Flight'.tr)),
      body: GetNearestAirports(
        context,
        _searchController,
        searchCityNameController,
        nearestController,
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
