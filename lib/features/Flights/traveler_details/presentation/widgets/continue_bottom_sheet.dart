import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../../main.dart';
import '../../domain/order-controller.dart';
import '../../domain/price_controller.dart';

class ContinueBottomSheet extends StatelessWidget {
  const ContinueBottomSheet({
    super.key,
    required this.adultAdded,
    required this.priceController,
    required this.bookingRequirements,
    required this.flightOffer,
    required this.travelers,
    required this.contacts,
    required this.ticketingAgreement,
  });
  final bool adultAdded;
  final PriceController priceController;
  final Map<String, dynamic> bookingRequirements;

  final Map<String, dynamic> flightOffer;
  final List<Map<String, dynamic>> travelers;
  final List<Map<String, dynamic>> contacts;
  final Map<String, dynamic> ticketingAgreement;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ElevatedButton(
            onPressed: () async {
              var box = await Hive.openBox('travelerDetails');
              var firstName = box.get('firstName');
              var lastName = box.get('lastName');

              if (firstName != null && lastName != null) {
                final emailRequired = priceController.pricingModel.value?.data
                        ?.data?.bookingRequirements?.emailAddressRequired ??
                    false;
                final postalCodeRequired = priceController.pricingModel.value
                        ?.data?.data?.bookingRequirements?.postalCodeRequired ??
                    false;
                final phoneNumberRequired = priceController
                        .pricingModel
                        .value
                        ?.data
                        ?.data
                        ?.bookingRequirements
                        ?.phoneNumberRequired ??
                    false;
                final countryCodeRequired = priceController
                        .pricingModel
                        .value
                        ?.data
                        ?.data
                        ?.bookingRequirements
                        ?.countryCodeRequired ??
                    false;
                final invoiceRequired = priceController.pricingModel.value?.data
                        ?.data?.bookingRequirements?.invoiceRequired ??
                    false;
                final mailingAddressRequired = priceController
                        .pricingModel
                        .value
                        ?.data
                        ?.data
                        ?.bookingRequirements
                        ?.mailingAddressRequired ??
                    false;

                if (emailRequired &&
                    OrderController.emailController.text.isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Error',
                    message: 'Email is required',
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }

                if (postalCodeRequired &&
                    OrderController.postalCodeController.text.isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Error',
                    message: 'Postal code is required',
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }

                if (phoneNumberRequired &&
                    OrderController.phoneNumberController.text.isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Error',
                    message: 'Mobile phone number is required',
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }

                if (countryCodeRequired &&
                    OrderController.countryCodePhoneController.text.isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Error',
                    message: 'Country code is required',
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }

                if (invoiceRequired &&
                    OrderController.invoiceAddressController.text.isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Error',
                    message: 'Invoice address is required',
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }

                if (mailingAddressRequired &&
                    OrderController.mailingAddressController.text.isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Error',
                    message: 'Mailing address is required',
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }
                print("documents: ${offersController.documents}");
                try {
                  orderController.isLoading.value = true;
                  await orderController.createOrder(
                    flightOffer: flightOffer,
                    travelers: travelers,
                    contacts: contacts,
                    ticketingAgreement: ticketingAgreement,
                    bookingRequirements: bookingRequirements,
                  );
                } catch (e) {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'error',
                    message: 'Error creating order',
                    duration: Duration(seconds: 2),
                  ));
                } finally {
                  orderController.isLoading.value = false;
                }
              } else {
                Get.showSnackbar(const GetSnackBar(
                  title: 'error',
                  message: 'Adult must be added first',
                  duration: Duration(seconds: 2),
                ));
              }
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 40), backgroundColor: Colors.red),
            child: orderController.isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
