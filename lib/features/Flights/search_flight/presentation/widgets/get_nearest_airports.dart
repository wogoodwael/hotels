import 'package:flights/features/Flights/search_flight/domain/nearest_controller.dart';
import 'package:flights/features/Flights/search_flight/domain/search_city_name_controller.dart';
import 'package:flights/features/Flights/search_flight/presentation/search_flight_taps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

Column GetNearestAirports(
    BuildContext context,
    TextEditingController searchController,
    SearchCityNameController searchCityNameController,
    NearestController nearestController,
    void Function(double radius) getCurrentLocation,
    double radius,
    bool isdestination) {
  final flightBox = Hive.box('flightData');

  Future<void> handleAirportSelection(
      String iataCode, String cityName, String countryName) async {
    if (isdestination) {
      await flightBox.put('destination', {
        'iataCode': iataCode,
        'cityName': cityName,
        'countryName': countryName
      });
    } else {
      await flightBox.put('source', {
        'iataCode': iataCode,
        'cityName': cityName,
        'countryName': countryName
      });
    }

    searchController.clear();
    nearestController.getNearestAirports();

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const SearchFlightsPage()));
  }

  return Column(
    children: [
      Container(
        width: .9 * MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            searchCityNameController.searchCityName(value);
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            hintText: "search for city or airport",
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => getCurrentLocation(radius),
          child: Container(
            child: Row(
              children: [
                const Icon(
                  Icons.location_searching_outlined,
                  color: Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  'Use Current Location',
                  style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
      const Divider(
        indent: 20,
        endIndent: 20,
      ),
      Expanded(
        child: Obx(() {
          if (searchController.text.isEmpty) {
            if (nearestController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (nearestController.error.isNotEmpty) {
              return Center(child: Text(nearestController.error));
            }

            final airports = nearestController.nearestAirports?.data.data ?? [];

            if (airports.isEmpty) {
              return const Center(child: Text('No airports found'));
            }

            return ListView.builder(
              itemCount: airports.length,
              itemBuilder: (context, index) {
                final airport = airports[index];
                return ListTile(
                  title: Text('${airport.name} ${airport.subType}'),
                  subtitle: Text(
                      '${airport.address.cityName} ${airport.address.countryName}'),
                  trailing: Container(
                    width: 40,
                    height: 30,
                    color: Colors.grey.withOpacity(.2),
                    child: Center(child: Text(airport.iataCode)),
                  ),
                  onTap: () => handleAirportSelection(airport.iataCode,
                      airport.address.cityName, airport.address.countryName),
                );
              },
            );
          } else {
            if (searchCityNameController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (searchCityNameController.error.isNotEmpty) {
              return Center(child: Text(searchCityNameController.error.value));
            }

            final searchResults =
                searchCityNameController.searchResults.value?.data.data ?? [];

            if (searchResults.isEmpty) {
              return const Center(child: Text('No results found'));
            }

            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final result = searchResults[index];
                return ListTile(
                  title: Text('${result.name} ${result.subType}'),
                  subtitle: Text(
                      '${result.address.cityName}, ${result.address.countryName}'),
                  trailing: Container(
                    width: 40,
                    height: 30,
                    color: Colors.grey.withOpacity(.2),
                    child: Center(child: Text(result.iataCode)),
                  ),
                  onTap: () => handleAirportSelection(result.iataCode,
                      result.address.cityName, result.address.countryName),
                );
              },
            );
          }
        }),
      ),
    ],
  );
}
