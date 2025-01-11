import '../api/offers_api.dart';
import '../models/offers_model.dart';

class OffersRepo {
  final OffersApi offersApi;

  OffersRepo({required this.offersApi});

  Future<OffersModel> getFlightOffers(
      {required String originLocationCode,
      required String destinationLocationCode,
      required String departureDate,
      int? adults = 1,
      String? returnDate,
      int? children,
      int? infants,
      String? travelClass,
      String? includedAirlineCodes,
      String? excludedAirlineCodes,
      bool? nonStop,
      String? currencyCode,
      double? maxPrice,
      int? max}) async {
    return await offersApi.getFlightOffers(
        originLocationCode: originLocationCode,
        destinationLocationCode: destinationLocationCode,
        departureDate: departureDate,
        adults: adults,
        returnDate: returnDate,
        children: children,
        infants: infants,
        travelClass: travelClass,
        includedAirlineCodes: includedAirlineCodes,
        excludedAirlineCodes: excludedAirlineCodes,
        nonStop: nonStop,
        currencyCode: currencyCode,
        maxPrice: maxPrice,
        max: max);
  }
}
