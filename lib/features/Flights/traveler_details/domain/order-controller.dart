import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repo/order_repo.dart';
import '../presentation/upgrade_experience.dart';

class OrderController extends GetxController {
  final OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  var isLoading = false.obs;
  var error = ''.obs;
  static var gender = ''.obs;
  static TextEditingController birthPlace = TextEditingController();
  static TextEditingController issuanceLocation = TextEditingController();
  static var issuanceDate = ''.obs;
  static TextEditingController number = TextEditingController();
  static var expiryDate = ''.obs;
  static TextEditingController issuanceCountry = TextEditingController();
  static TextEditingController validityCountry = TextEditingController();
  static TextEditingController nationality = TextEditingController();
  
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController phoneNumberController =
      TextEditingController();
  static final TextEditingController postalCodeController =
      TextEditingController();
  static final TextEditingController countryCodeController =
      TextEditingController();
  static final TextEditingController mobilePhoneNumberController =
      TextEditingController();
  static final TextEditingController countryCodePhoneController =
      TextEditingController();
  static final TextEditingController invoiceAddressController =
      TextEditingController();
  static final TextEditingController mailingAddressController =
      TextEditingController();
  static final TextEditingController firstNameController = TextEditingController();
  static final TextEditingController emailAdultController = TextEditingController();
  static final TextEditingController lastNameController = TextEditingController();
  static final TextEditingController countryCallingCodeAdultController = TextEditingController();
  static final TextEditingController mobilePhoneNumberAdultController = TextEditingController();
  static var dateOfBirth = ''.obs;

  
  static void clearControllers() {
    emailController.clear();
    phoneNumberController.clear();
    postalCodeController.clear();
    countryCodeController.clear();
    mobilePhoneNumberController.clear();
    countryCodePhoneController.clear();
    invoiceAddressController.clear();
    mailingAddressController.clear();
    birthPlace.clear();
    issuanceLocation.clear();
  
    number.clear();

    issuanceCountry.clear();
    validityCountry.clear();
    nationality.clear();
  }

  
  @override
  void onClose() {
    emailController.dispose();
    phoneNumberController.dispose();
    postalCodeController.dispose();
    countryCodeController.dispose();
    mobilePhoneNumberController.dispose();
    countryCodePhoneController.dispose();
    invoiceAddressController.dispose();
    mailingAddressController.dispose();
    super.onClose();
  }

  Future<void> createOrder({
    required Map<String, dynamic> flightOffer,
    required List<Map<String, dynamic>> travelers,
    required List<Map<String, dynamic>> contacts,
    required Map<String, dynamic> ticketingAgreement,
    required Map<String, dynamic> bookingRequirements,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await orderRepo.createOrder(
        flightOffer: flightOffer,
        travelers: travelers,
        contacts: contacts,
        ticketingAgreement: ticketingAgreement,
        bookingRequirements: bookingRequirements,
      );

      
      print('Order created successfully: $response');
      Get.to(() => const UpgradeExperienceScreen());
    } catch (e) {
      error.value = e.toString();
      print('Error creating order: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
