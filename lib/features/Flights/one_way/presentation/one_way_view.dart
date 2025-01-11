import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'widgets/flights_details_section.dart';
import 'widgets/passenget_section.dart';
import 'widgets/search_button.dart';
import 'package:intl/intl.dart';

class OneWayTab extends StatefulWidget {
  const OneWayTab({super.key});

  @override
  State<OneWayTab> createState() => _OneWayTabState();
}

class _OneWayTabState extends State<OneWayTab> {
  Map<String, dynamic>? sourceData;
  Map<String, dynamic>? destinationData;
  bool isCleared = false;
  bool nonStop = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFlightData();
  }

  void _loadFlightData() {
    final source = Hive.box('flightData').get('source');
    final destination = Hive.box('flightData').get('destination');

    setState(() {
      sourceData = source != null 
          ? Map<String, dynamic>.from(source as Map) 
          : null;
      destinationData = destination != null 
          ? Map<String, dynamic>.from(destination as Map)
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const FlightDetailsSection(),
                    const PassengerClassSection(),
                    const Divider(
                      indent: 30,
                      endIndent: 10,
                      height: 0,
                    ),
                    CheckboxListTile(
                      checkColor: Colors.white,
                      activeColor: Colors.teal,
                      hoverColor: Colors.grey,
                      value: nonStop,
                      onChanged: (value) {
                        setState(() {
                          nonStop = value ?? false;
                        });
                      },
                      title: const Text('Show direct flights only'),
                      controlAffinity: ListTileControlAffinity.leading,
                      side: const BorderSide(color: Colors.grey),
                    ),
                     SearchButton(nonStop: nonStop),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            isCleared
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recent Searches",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Hive.box('flightData').clear();
                            setState(() {
                              isCleared = true;
                            });
                          },
                          child: const Text(
                            "Clear all",
                            style: TextStyle(color: Colors.teal),
                          ),
                        ),
                      ],
                    ),
                  ),
            isCleared
                ? const SizedBox()
                : SizedBox(
                    width: .9 * MediaQuery.of(context).size.width,
                    child: ListTile(
                      minVerticalPadding: 0,
                      minLeadingWidth: 0,
                      title: const Text("one-way"),
                      subtitle: Text(
                        "${sourceData?['cityName'] ?? ""} to ${destinationData?['cityName'] ?? ""}",
                        textAlign: TextAlign.start,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(.1),
                            ),
                            child: Center(
                                child: Text(
                              DateFormat('dd MMM').format(DateTime.tryParse(
                                      Hive.box('flightData')
                                              .get('departureDate') ??
                                          "") ??
                                  DateTime.now()),
                            )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.teal,
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
