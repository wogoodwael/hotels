import 'package:flutter/material.dart';

import '../../../one_way/presentation/widgets/flights_details_section.dart';

class MultiCityBody extends StatelessWidget {
  const MultiCityBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: List.generate(2, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: .9 * MediaQuery.sizeOf(context).width,
                    height: .3 * MediaQuery.sizeOf(context).height,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text("Flight $index"),
                            leading: const Icon(Icons.flight),
                          ),
                        ),
                        const FlightDetailsSection(showReturn: false)
                      ],
                    ),
                  );
                }),
              ),
            ),
            MaterialButton(
              elevation: 0,
              minWidth: .7 * MediaQuery.of(context).size.width,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.teal)),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.teal,
                  ),
                  Text(
                    'Add another flight?',
                    style: TextStyle(fontSize: 16, color: Colors.teal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
