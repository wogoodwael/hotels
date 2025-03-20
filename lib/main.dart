import 'package:flights/search_flight_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  await Hive.openBox('flightData');
  await Hive.openBox('travelerDetails');
  await Hive.openBox('hotelData');

  runApp( SearchFlightsApp());
}
