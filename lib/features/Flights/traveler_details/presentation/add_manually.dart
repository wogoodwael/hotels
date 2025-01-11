import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../shared/widgets/custom_text_field.dart';
import '../domain/order-controller.dart';
import '../../offers/domain/offers_controller.dart';

class AddManuallyScreen extends StatelessWidget {
  final int travelerIndex;

  const AddManuallyScreen({super.key, required this.travelerIndex});

  @override
  Widget build(BuildContext context) {
    final offersController = Get.find<OffersController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Traveler Details'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Passport Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Birth Place',
              controller: OrderController.birthPlace,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Birth place is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Issuance Location',
              controller: OrderController.issuanceLocation,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Issuance location is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Obx(() => CustomTextField(
                  labelText: 'Issuance Date',
                  controller: TextEditingController(
                    text: OrderController.issuanceDate.value,
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Issuance date is required';
                    }
                    return null;
                  },
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      OrderController.issuanceDate.value =
                          DateFormat('yyyy-MM-dd').format(picked);
                    }
                  },
                )),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Passport Number',
              controller: OrderController.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Passport number is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Obx(() => CustomTextField(
                  labelText: 'Expiry Date',
                  controller: TextEditingController(
                    text: OrderController.expiryDate.value,
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Expiry date is required';
                    }
                    return null;
                  },
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      OrderController.expiryDate.value =
                          DateFormat('yyyy-MM-dd').format(picked);
                    }
                  },
                )),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Issuance Country (e.g. FR for France)',
              controller: OrderController.issuanceCountry,
              maxLength: 2,
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                if (value.length == 2) {
                  OrderController.issuanceCountry.text = value.toUpperCase();
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty || value.length != 2) {
                  return 'Please enter a valid 2-letter country code';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Validity Country (e.g. FR for France)',
              controller: OrderController.validityCountry,
              maxLength: 2,
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                if (value.length == 2) {
                  OrderController.validityCountry.text = value.toUpperCase();
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty || value.length != 2) {
                  return 'Please enter a valid 2-letter country code';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Nationality (e.g. FR for France)',
              controller: OrderController.nationality,
              maxLength: 2,
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                if (value.length == 2) {
                  OrderController.nationality.text = value.toUpperCase();
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty || value.length != 2) {
                  return 'Please enter a valid 2-letter country code';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate all fields
                  if (OrderController.birthPlace.text.isEmpty ||
                      OrderController.issuanceLocation.text.isEmpty ||
                      OrderController.issuanceDate.value.isEmpty ||
                      OrderController.number.text.isEmpty ||
                      OrderController.expiryDate.value.isEmpty ||
                      OrderController.issuanceCountry.text.length != 2 ||
                      OrderController.validityCountry.text.length != 2 ||
                      OrderController.nationality.text.length != 2) {
                    Get.snackbar(
                      'Error',
                      'Please fill in all required fields correctly',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  final document = {
                    "documentType": "PASSPORT",
                    "birthPlace": OrderController.birthPlace.text,
                    "issuanceLocation": OrderController.issuanceLocation.text,
                    "issuanceDate": OrderController.issuanceDate.value,
                    "number": OrderController.number.text,
                    "expiryDate": OrderController.expiryDate.value,
                    "issuanceCountry":
                        OrderController.issuanceCountry.text.toUpperCase(),
                    "validityCountry":
                        OrderController.validityCountry.text.toUpperCase(),
                    "nationality":
                        OrderController.nationality.text.toUpperCase(),
                    "holder": true
                  };
                  //offersController.documents.clear();
                  // Update document for specific traveler
                  while (offersController.documents.length <= travelerIndex) {
                    offersController.documents.add({});
                  }
                  offersController.documents[travelerIndex] = document;
                  
                  Get.close(2);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(300, 50),
                ),
                child: const Text(
                  'Save Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
