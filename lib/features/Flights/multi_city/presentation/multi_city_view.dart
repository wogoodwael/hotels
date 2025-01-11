import 'package:flights/features/Flights/multi_city/presentation/widgets/container_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../one_way/presentation/widgets/flights_details_section.dart';
import 'widgets/multi_city_body.dart';

class MultiCityTab extends StatefulWidget {
  const MultiCityTab({super.key});

  @override
  _MultiCityTabState createState() => _MultiCityTabState();
}

class _MultiCityTabState extends State<MultiCityTab> {
  List<Widget> flightSections = [
    const FlightDetailsSection(),
  ];

  void addFlightSection() {
    setState(() {
      flightSections.add(const FlightDetailsSection());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MultiCityBody(),
      bottomNavigationBar: ContainerBottomNavBar(),
    );
  }
}
