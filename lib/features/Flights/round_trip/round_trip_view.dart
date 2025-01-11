import 'package:flutter/material.dart';

import '../one_way/presentation/widgets/flights_details_section.dart';
import '../one_way/presentation/widgets/passenget_section.dart';
import '../one_way/presentation/widgets/search_button.dart';

class RoundTripTab extends StatefulWidget {
  const RoundTripTab({super.key});

  @override
  State<RoundTripTab> createState() => _RoundTripTabState();
}

class _RoundTripTabState extends State<RoundTripTab> {
  @override
  Widget build(BuildContext context) {
  bool nonStop = false;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: .9 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: SingleChildScrollView(
              child: Column(
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Searches",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Clear all",
                  style: TextStyle(color: Colors.teal),
                ),
              ],
            ),
          ),
          SizedBox(
            width: .9 * MediaQuery.of(context).size.width,
            child: ListTile(
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              title: const Text("one-way"),
              subtitle: const Text(
                "Delhi to Mumbai",
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
                    child: const Center(child: Text("24Nov")),
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
    );
  }
}
