import 'package:flights/features/Flights/search_flight/presentation/widgets/search_flight_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchFlightsPage extends StatefulWidget {
  const SearchFlightsPage({super.key, this.isRoundTrip = false});
  final bool isRoundTrip;
  @override
  _SearchFlightsPageState createState() => _SearchFlightsPageState();
}

class _SearchFlightsPageState extends State<SearchFlightsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _currentHeight = 0.8;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (widget.isRoundTrip) {
      _tabController.index = 1;
    }
    Hive.box('flightData').get('source');
    Hive.box('flightData').get('destination');
    _tabController.addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            _currentHeight = 0.8;
            break;
          case 1:
            _currentHeight = 0.8;
            break;
          case 2:
            _currentHeight = 0.8;
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Search flights'.tr,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.teal,
          tabs: [
            Tab(text: 'one-way'.tr),
             Tab(text: 'Round-trip'.tr),
             Tab(text: 'Multi-city'.tr),
          ],
        ),
      ),
      body: SearchFlightBody(
          currentHeight: _currentHeight,
          tabController: _tabController,
          isRoundTrip: widget.isRoundTrip),
    );
  }
}
