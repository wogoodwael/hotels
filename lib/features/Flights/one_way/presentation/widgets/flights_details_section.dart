import 'package:flights/features/Flights/one_way/presentation/widgets/date_field.dart';
import 'package:flights/features/Flights/one_way/presentation/widgets/location_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../search_flight/presentation/search_flight_view.dart';

class FlightDetailsSection extends StatefulWidget {
  final bool showReturn;

  const FlightDetailsSection({super.key, this.showReturn = true});

  @override
  State<FlightDetailsSection> createState() => _FlightDetailsSectionState();
}

class _FlightDetailsSectionState extends State<FlightDetailsSection> {
  Map<String, dynamic>? sourceData;
  Map<String, dynamic>? destinationData;
  bool _isReturnAdded = false;

  @override
  void initState() {
    super.initState();

    _loadFlightData();
  }

  void _loadFlightData() {
    final source = Hive.box('flightData').get('source');
    final destination = Hive.box('flightData').get('destination');

    setState(() {
      sourceData = source != null ? Map<String, dynamic>.from(source) : null;
      destinationData =
          destination != null ? Map<String, dynamic>.from(destination) : null;
    });
  }

  void _swapLocations() {
    setState(() {
      final temp = sourceData;
      sourceData = destinationData;
      destinationData = temp;

      Hive.box('flightData').put('source', sourceData);
      Hive.box('flightData').put('destination', destinationData);
    });
  }

  void _toggleReturn() {
    setState(() {
      _isReturnAdded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                LocationField(
                  title: 'From'.tr,
                  hintText: sourceData?['cityName'] ?? 'Select Source'.tr,
                  icon: Icons.location_searching_rounded,
                  onTap: () {
                    Get.to(() => const SearchFlightView(isdestination: false));
                  },
                ),
                SizedBox(
                  width: .7 * MediaQuery.of(context).size.width,
                  child: const Divider(indent: 20, height: 4),
                ),
                const SizedBox(height: 10),
                LocationField(
                  title: 'to'.tr,
                  hintText:
                      destinationData?['cityName'] ?? 'Select Destination'.tr,
                  icon: Icons.location_on,
                  onTap: () {
                    Get.to(() => const SearchFlightView(isdestination: true));
                  },
                ),
              ],
            ),
            GestureDetector(
              onTap: _swapLocations,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Center(
                  child: Icon(
                    Icons.swap_vert_sharp,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(indent: 30, endIndent: 10, height: 4),
        const SizedBox(height: 10),
        DateField(
          title: 'Departure date',
          date: '22 Nov, 2024',
          showReturn: widget.showReturn,
        ),
        widget.showReturn
            ? const Divider(indent: 30, endIndent: 10)
            : const SizedBox(),
      ],
    );
  }
}
