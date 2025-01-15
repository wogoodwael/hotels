import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../Hotels/searchHotel/presentation/search_hotels_page.dart';
import '../../../search_flight/presentation/search_flight_taps.dart';

class PassengerClassPage extends StatefulWidget {
  const PassengerClassPage({super.key, required this.isHotel});
  final bool isHotel;

  @override
  _PassengerClassPageState createState() => _PassengerClassPageState();
}

class _PassengerClassPageState extends State<PassengerClassPage> {
  int adults = 2;
  int children = 1;
  int infants = 1;
  String cabinClass = 'First';
  late final Box _flightBox;

  @override
  void initState() {
    super.initState();
    _flightBox = widget.isHotel ? Hive.box('hotelData') : Hive.box('flightData');
    
    adults = _flightBox.get('adults', defaultValue: 2);
    children = _flightBox.get('children', defaultValue: 1);
    infants = _flightBox.get('infants', defaultValue: 1);
    cabinClass = _flightBox.get('cabinClass', defaultValue: 'First');
  }

  void increment(String type) {
    setState(() {
      if (type == 'Adults') adults++;
      if (type == 'Children') children++;
      if (type == 'Infants') infants++;
    });
  }

  void decrement(String type) {
    setState(() {
      if (type == 'Adults' && adults > 0) adults--;
      if (type == 'Children' && children > 0) children--;
      if (type == 'Infants' && infants > 0) infants--;
    });
  }

  void _saveToHive() {
    _flightBox.put('adults', adults);
    _flightBox.put('children', children);
    _flightBox.put('infants', infants);
    _flightBox.put('cabinClass', cabinClass);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => widget.isHotel ? const SearchHotelsPage() : const SearchFlightsPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Travellers & cabin class'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            
            Container(
                width: .9 * MediaQuery.of(context).size.width,
                height: .36 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    Container(
                      width: .9 * MediaQuery.sizeOf(context).width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Colors.grey.withOpacity(.1),
                      ),
                      child: const ListTile(
                        title: Text(
                          'Travellers',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        leading: Icon(Icons.group),
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildCounterRow('Adults', 'Age (12+)', adults),
                    buildCounterRow('Children', 'Age (2-11)', children),
                    buildCounterRow('Infants', 'Age (Under 2 years)', infants),
                  ],
                )),
            const SizedBox(height: 15),
            if(!widget.isHotel)
            
            Container(
              width: .9 * MediaQuery.of(context).size.width,
              height: .36 * MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  Container(
                    width: .9 * MediaQuery.sizeOf(context).width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.grey.withOpacity(.1),
                    ),
                    child: const ListTile(
                      title: Text(
                        'Cabin class',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      leading: Icon(Icons.chair_alt_rounded),
                    ),
                  ),
                  buildRadioOption('Economy'),
                  buildRadioOption('Premium Economy'),
                  buildRadioOption('Business'),
                  buildRadioOption('First'),
                ],
              ),
            ),

            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveToHive,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCounterRow(String label, String subtitle, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 16)),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => decrement(label),
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.teal,
                  size: 25,
                ),
              ),
              Text(value.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400)),
              IconButton(
                onPressed: () => increment(label),
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.teal,
                  size: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRadioOption(String label) {
    return RadioListTile<String>(
      activeColor: Colors.teal,
      title: Text(label),
      value: label,
      groupValue: cabinClass,
      onChanged: (value) {
        setState(() {
          cabinClass = value!;
        });
      },
    );
  }
}
