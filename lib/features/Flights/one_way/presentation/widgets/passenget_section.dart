import 'package:flights/features/Flights/one_way/presentation/widgets/passenger_class_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PassengerClassSection extends StatelessWidget {
  const PassengerClassSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const PassengerClassPage()),
      child: ListTile(
        leading: const Icon(
          Icons.group,
          color: Colors.grey,
        ),
        title: const Text(
          'Passengers and cabin Class',
          style: TextStyle(fontSize: 12),
        ),
        subtitle: Text(
            '${Hive.box('flightData').get('adults', defaultValue: 2)} Adults - '
            '${Hive.box('flightData').get('children', defaultValue: 0)} Children - '
            '${Hive.box('flightData').get('infants', defaultValue: 0)} Infants - '
            '${Hive.box('flightData').get('cabinClass', defaultValue: 'First')} '),
      ),
    );
  }
}
