import 'package:hive_flutter/hive_flutter.dart';

const String baseUrl = 'https://iserve-uae.com/wisal_api/public/api';
List details = ['MALE', 'FEMALE', 'OTHER'];
final destination = Hive.box('flightData').get('destination');
final source = Hive.box('flightData').get('source');
String formatTravelClass(String? cabinClass) {
  switch (cabinClass?.toUpperCase()) {
    case 'FIRST':
      return 'FIRST';
    case 'BUSINESS':
      return 'BUSINESS';
    default:
      return 'ECONOMY';
  }
}
