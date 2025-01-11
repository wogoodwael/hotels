import 'package:flights/features/Flights/search_flight/presentation/search_flight_taps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/Hotels/home/home.dart';

class SearchFlightsApp extends StatelessWidget {
  const SearchFlightsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
