import 'package:flutter/material.dart';

import '../../../multi_city/presentation/multi_city_view.dart';
import '../../../one_way/presentation/one_way_view.dart';
import '../../../round_trip/round_trip_view.dart';

class SearchFlightBody extends StatelessWidget {
  const SearchFlightBody({
    super.key,
    required double currentHeight,
    required TabController tabController,
    required this.isRoundTrip,
  })  : _currentHeight = currentHeight,
        _tabController = tabController;

  final double _currentHeight;
  final TabController _tabController;
  final bool isRoundTrip;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height * _currentHeight,
      width: MediaQuery.of(context).size.width,
      child: TabBarView(
        controller: _tabController,
        children: const [
          OneWayTab(),
          RoundTripTab(),
          MultiCityTab(),
        ],
      ),
    );
  }
}
