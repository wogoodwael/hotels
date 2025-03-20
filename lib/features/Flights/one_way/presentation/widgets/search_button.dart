import 'package:flights/features/Flights/offers/domain/offers_controller.dart';
import 'package:flights/features/Flights/offers/presentation/offers_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../utils/constants/strings.dart';

class SearchButton extends StatelessWidget {
  final bool nonStop;
  SearchButton({
    super.key,
    required this.nonStop,
  });
  final OffersController _offersController = Get.find<OffersController>();
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      minWidth: .7 * MediaQuery.of(context).size.width,
      height: 45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.red,
      onPressed: () {
        final departureDate = Hive.box('flightData').get('departureDate');
        print('departureDate: $departureDate');

        final formattedDepartureDate = DateTime.tryParse(departureDate ?? '')
            ?.toIso8601String()
            .split('T')
            .first;
        print('formattedDepartureDate: $formattedDepartureDate');

        final returnDate = Hive.box('flightData').get('returnDate') ?? "";
        print('returnDate: $returnDate');

        String? formattedReturnDate;
        if (returnDate != null && returnDate is String) {
          formattedReturnDate = DateTime.tryParse(returnDate)
                  ?.toIso8601String()
                  .split('T')
                  .first ??
              "";
        }
        print('formattedReturnDate: $formattedReturnDate');

        final adults = Hive.box('flightData').get('adults');
        print('adults: $adults');

        final children = Hive.box('flightData').get('children');
        print('children: $children');

        final infants = Hive.box('flightData').get('infants');
        print('infants: $infants');

        final cabinClass = Hive.box('flightData').get('cabinClass');
        print('cabinClass: $cabinClass');

        _offersController.getFlightOffers(
          originLocationCode: source != null ? source['iataCode'] : '',
          destinationLocationCode:
              destination != null ? destination['iataCode'] : '',
          departureDate: formattedDepartureDate ?? '',
          returnDate: formattedReturnDate,
          adults: adults ?? 1,
          children: children ?? 0,
          infants: infants ?? 0,
          travelClass: formatTravelClass(cabinClass),
          nonStop: nonStop,
        );
        Get.to(() => FlightBookingScreen(nonStop: nonStop));
      },
      child:  Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Text(
            'Search flights'.tr,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
