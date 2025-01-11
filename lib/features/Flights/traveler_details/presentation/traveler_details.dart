import 'package:flights/features/Flights/offers/domain/offers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../utils/constants/strings.dart';
import '../domain/order-controller.dart';
import '../domain/price_controller.dart';
import 'widgets/adult_container.dart';
import 'widgets/contact_details_container.dart';
import 'widgets/continue_bottom_sheet.dart';

class TravellerDetailsScreen extends StatefulWidget {
  const TravellerDetailsScreen(
      {super.key, required this.flightOffer, required this.travelerId});
  final Map<String, dynamic> flightOffer;
  final String travelerId;
  @override
  State<TravellerDetailsScreen> createState() => _TravellerDetailsScreenState();
}

class _TravellerDetailsScreenState extends State<TravellerDetailsScreen> {
  bool adultAdded = false;
  final OffersController offersController = Get.find<OffersController>();
  final PriceController priceController = Get.find<PriceController>();

  @override
  void initState() {
    super.initState();
    OrderController.emailController.addListener(_updateControllerValues);
    OrderController.phoneNumberController.addListener(_updateControllerValues);
    OrderController.countryCodePhoneController
        .addListener(_updateControllerValues);
    OrderController.postalCodeController.addListener(_updateControllerValues);
    OrderController.countryCodeController.addListener(_updateControllerValues);
    OrderController.birthPlace.addListener(_updateControllerValues);
    OrderController.issuanceLocation.addListener(_updateControllerValues);
    OrderController.number.addListener(_updateControllerValues);
    OrderController.issuanceCountry.addListener(_updateControllerValues);
    OrderController.validityCountry.addListener(_updateControllerValues);
    OrderController.nationality.addListener(_updateControllerValues);
    OrderController.firstNameController.addListener(_updateControllerValues);
    OrderController.emailAdultController.addListener(_updateControllerValues);
    OrderController.lastNameController.addListener(_updateControllerValues);
    OrderController.countryCallingCodeAdultController
        .addListener(_updateControllerValues);
    OrderController.mobilePhoneNumberAdultController
        .addListener(_updateControllerValues);

    if (offersController.travelers.isNotEmpty) {
      final traveler = offersController.travelers[0];
      OrderController.firstNameController.text =
          traveler['name']['firstName'] ?? '';
      OrderController.lastNameController.text =
          traveler['name']['lastName'] ?? '';
      OrderController.emailAdultController.text =
          traveler['contact']['emailAddress'] ?? '';
      OrderController.dateOfBirth.value = traveler['dateOfBirth'] ?? '';
      OrderController.countryCallingCodeAdultController.text =
          traveler['contact']['phones'][0]['countryCallingCode'] ?? '';
      OrderController.mobilePhoneNumberAdultController.text =
          traveler['contact']['phones'][0]['number'] ?? '';
    } else {
      _loadDataFromHive();
    }
  }

  @override
  void dispose() {
    OrderController.emailController.removeListener(_updateControllerValues);
    OrderController.phoneNumberController
        .removeListener(_updateControllerValues);
    OrderController.countryCodePhoneController
        .removeListener(_updateControllerValues);
    OrderController.postalCodeController
        .removeListener(_updateControllerValues);
    OrderController.countryCodeController
        .removeListener(_updateControllerValues);
    OrderController.birthPlace.removeListener(_updateControllerValues);
    OrderController.issuanceLocation.removeListener(_updateControllerValues);
    OrderController.number.removeListener(_updateControllerValues);
    OrderController.issuanceCountry.removeListener(_updateControllerValues);
    OrderController.validityCountry.removeListener(_updateControllerValues);
    OrderController.nationality.removeListener(_updateControllerValues);
    OrderController.firstNameController.removeListener(_updateControllerValues);
    OrderController.emailAdultController
        .removeListener(_updateControllerValues);
    OrderController.lastNameController.removeListener(_updateControllerValues);
    OrderController.countryCallingCodeAdultController
        .removeListener(_updateControllerValues);
    OrderController.mobilePhoneNumberAdultController
        .removeListener(_updateControllerValues);
    super.dispose();
  }

  void _updateControllerValues() {
    setState(() {});
  }

  void _loadDataFromHive() async {
    var box = await Hive.openBox('travelerDetails');

    OrderController.firstNameController.text =
        box.get('firstName', defaultValue: '');
    OrderController.emailAdultController.text =
        box.get('email', defaultValue: '');
    OrderController.lastNameController.text =
        box.get('lastName', defaultValue: '');
    OrderController.dateOfBirth.value =
        box.get('dateOfBirth', defaultValue: '');
    OrderController.countryCallingCodeAdultController.text =
        box.get('countryCallingCode', defaultValue: '');
    OrderController.mobilePhoneNumberAdultController.text =
        box.get('mobilePhoneNumber', defaultValue: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Traveller Details"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Obx(() {
        if (priceController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    'Total to be paid ',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  subtitle: Text(
                    "SAR ${priceController.pricingModel.value?.data?.data?.flightOffers?[0].price.total}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  trailing: const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      "VIEW BOOKING SUMMARY",
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Traveller Detials",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  spacing: 20,
                  children: List.generate(
                      offersController.travelerPricingLength,
                      (index) => AdultContainer(
                            index: index,
                          )),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Contact Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    return Obx(() {
                      return MaterialButton(
                        minWidth: 100,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        color: OrderController.gender.value == details[index]
                            ? Colors.teal
                            : Colors.white,
                        onPressed: () {
                          if (index == 0) {
                            OrderController.gender.value = 'MALE';
                          } else if (index == 1) {
                            OrderController.gender.value = 'FEMALE';
                          } else {
                            OrderController.gender.value = 'OTHER';
                          }
                        },
                        child: Text(details[index],
                            style:
                                OrderController.gender.value == details[index]
                                    ? const TextStyle(
                                        color: Colors.white, fontSize: 12)
                                    : const TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                      );
                    });
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                ContactDetailsContainer(
                  emailController: OrderController.emailController,
                  phoneNumberController: OrderController.phoneNumberController,
                  countryCodePhoneController:
                      OrderController.countryCodePhoneController,
                  postalCodeController: OrderController.postalCodeController,
                  countryCodeController: OrderController.countryCodeController,
                  mobilePhoneNumberController:
                      OrderController.mobilePhoneNumberController,
                  invoiceAddressController:
                      OrderController.invoiceAddressController,
                  mailingAddressController:
                      OrderController.mailingAddressController,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    const Text("Save details to my profile"),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      }),
      bottomSheet: Obx(() {
        return ContinueBottomSheet(
          adultAdded: adultAdded,
          priceController: priceController,
          flightOffer: offersController.offers?.data.data.first.toJson() ?? {},
          travelers: offersController.travelers
              .asMap()
              .map((index, traveler) {
                if (index < offersController.documents.length) {
                  traveler['documents'] = [offersController.documents[index]];
                }
                return MapEntry(index, traveler);
              })
              .values
              .toList(),
          contacts: [
            {
              "addresseeName": const {
                "firstName": "PABLO",
                "lastName": "RODRIGUEZ"
              },
              "companyName": "INCREIBLE VIAJES",
              "purpose": "STANDARD",
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode":
                      OrderController.countryCodePhoneController.text,
                  "number": OrderController.phoneNumberController.text
                }
              ],
              "emailAddress": OrderController.emailController.text,
              "address": {
                "lines": const ["Calle Prado, 16"],
                "postalCode": OrderController.postalCodeController.text,
                "cityName": "Madrid",
                "countryCode":
                    OrderController.countryCodeController.text.toUpperCase()
              }
            }
          ],
          ticketingAgreement: const {},
          bookingRequirements: priceController
                  .pricingModel.value?.data?.data?.bookingRequirements
                  ?.toJson() ??
              {},
        );
      }),
    );
  }
}
