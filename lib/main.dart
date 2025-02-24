
import 'package:flights/search_flight_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('flightData');
  await Hive.openBox('travelerDetails');
  await Hive.openBox('hotelData');


  runApp(const SearchFlightsApp());
}
