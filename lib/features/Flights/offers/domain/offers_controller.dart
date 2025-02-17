import 'package:flights/features/Flights/traveler_details/domain/order-controller.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/repo/offers_repo.dart';
import '../data/models/offers_model.dart';

class OffersController extends GetxController {
  final OffersRepo offersRepo;

  OffersController({required this.offersRepo});

  final _isLoading = false.obs;
  final _error = ''.obs;
  final _offers = Rxn<OffersModel>();
  final _travelerPricingLength = 0.obs;

  final RxList<Map<String, dynamic>> travelers = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> documents = <Map<String, dynamic>>[].obs;

  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  OffersModel? get offers => _offers.value;
  int get travelerPricingLength => _travelerPricingLength.value;

  void addTraveler(Map<String, dynamic> travelerDetails) {
    travelers.add(travelerDetails);
  }

  void updateTraveler(int index, Map<String, dynamic> newDetails) {
    if (index >= 0 && index < travelers.length) {
      travelers[index] = newDetails;
    }
  }

  void removeTraveler(int index) {
    if (index >= 0 && index < travelers.length) {
      travelers.removeAt(index);
    }
  }

  Future<void> getFlightOffers(
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
    _isLoading.value = true;
    _error.value = '';

    try {
      final result = await offersRepo.getFlightOffers(
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
      _offers.value = result;
      _travelerPricingLength.value =
          result.data.data[0].travelerPricings.length;

      travelers.clear();

      for (var i = 0; i < _travelerPricingLength.value; i++) {
        travelers.add({
          "id": (i + 1).toString(),
          "dateOfBirth": OrderController.dateOfBirth.value,
          "name": {
            "firstName": OrderController.firstNameController.text,
            "lastName": OrderController.lastNameController.text
          },
          "gender": OrderController.gender.value,
          "contact": {
            "emailAddress": OrderController.emailController.text,
            "phones": [
              {
                "deviceType": "MOBILE",
                "countryCallingCode": OrderController
                        .countryCallingCodeAdultController.text.isNotEmpty
                    ? OrderController.countryCallingCodeAdultController.text
                        .replaceAll("+", "")
                    : null,
                "number": OrderController.mobilePhoneNumberAdultController.text
              }
            ]
          },
        });
      }

      print("Traveler Pricing Length: $_travelerPricingLength");
      print("Travelers: $travelers");
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Map<String, dynamic>? get _destination {
    final data = Hive.box('flightData').get('destination');
    if (data == null) return null;
    return Map<String, dynamic>.from(data as Map);
  }

  Map<String, dynamic>? get _source {
    final data = Hive.box('flightData').get('source');
    if (data == null) return null;
    return Map<String, dynamic>.from(data as Map);
  }

  String? get _departureDate =>
      Hive.box('flightData').get('departureDate') as String?;

  @override
  void onInit() {
    final formattedDepartureDate = DateTime.tryParse(_departureDate ?? '')
        ?.toIso8601String()
        .split('T')
        .first;

    super.onInit();
    getFlightOffers(
        originLocationCode: _source != null ? _source!['iataCode'] : '',
        destinationLocationCode:
            _destination != null ? _destination!['iataCode'] : '',
        departureDate: formattedDepartureDate ?? '');
  }
}
