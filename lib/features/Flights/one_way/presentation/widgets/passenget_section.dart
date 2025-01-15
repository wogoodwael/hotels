import 'package:flights/features/Flights/one_way/presentation/widgets/passenger_class_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PassengerClassSection extends StatelessWidget {
  const PassengerClassSection({super.key, required this.isHotel});
  final bool isHotel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => PassengerClassPage(
            isHotel: isHotel,
          )),
      child: ListTile(
        leading: const Icon(
          Icons.group,
          color: Colors.grey,
        ),
        title: Text(
          isHotel ? "Guests" : 'Passengers and cabin Class',
          style: const TextStyle(fontSize: 12),
        ),
        subtitle: Text(
            '${isHotel ? Hive.box('hotelData').get('adults', defaultValue: 2) : Hive.box('flightData').get('adults', defaultValue: 2)} Adults - '
            '${isHotel ? Hive.box('hotelData').get('children', defaultValue: 0) : Hive.box('flightData').get('children', defaultValue: 0)} Children - '
            '${isHotel ? Hive.box('hotelData').get('infants', defaultValue: 0) : Hive.box('flightData').get('infants', defaultValue: 0)} Infants - '
            '${isHotel ? "" : Hive.box('flightData').get('cabinClass', defaultValue: 'First')} '),
      ),
    );
  }
}
