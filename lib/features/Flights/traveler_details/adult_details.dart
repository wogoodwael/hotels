import 'package:flights/features/Flights/offers/domain/offers_controller.dart';
import 'package:flights/features/Flights/traveler_details/domain/order-controller.dart';
import 'package:flights/main.dart';
import 'package:flights/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants/strings.dart';
import 'scan_traveller_id.dart';

class AdultDetails extends StatefulWidget {
  final int? index;
  const AdultDetails({this.index, super.key});

  @override
  State<AdultDetails> createState() => _AdultDetailsState();
}

class _AdultDetailsState extends State<AdultDetails> {
  final OffersController offersController = Get.find<OffersController>();
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    dateController =
        TextEditingController(text: OrderController.dateOfBirth.value);
    OrderController.dateOfBirth.listen((value) {
      if (mounted) {
        dateController.text = value;
      }
    });

    OrderController.firstNameController.addListener(_updateControllerValues);
    OrderController.emailAdultController.addListener(_updateControllerValues);
    OrderController.lastNameController.addListener(_updateControllerValues);
    OrderController.countryCallingCodeAdultController
        .addListener(_updateControllerValues);
    OrderController.mobilePhoneNumberAdultController
        .addListener(_updateControllerValues);

    if (widget.index != null &&
        widget.index! < offersController.travelers.length) {
      final traveler = offersController.travelers[widget.index!];
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
    dateController.dispose();
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
    if (mounted) {
      setState(() {});
    }
  }

  void _loadDataFromHive() async {
    var box = await Hive.openBox('travelerDetails');

    if (!box.containsKey('firstName')) {
      await box.put('firstName', '');
    }
    if (!box.containsKey('email')) {
      await box.put('email', '');
    }
    if (!box.containsKey('lastName')) {
      await box.put('lastName', '');
    }
    if (!box.containsKey('dateOfBirth')) {
      await box.put('dateOfBirth', '');
    }
    if (!box.containsKey('countryCallingCode')) {
      await box.put('countryCallingCode', '');
    }
    if (!box.containsKey('mobilePhoneNumber')) {
      await box.put('mobilePhoneNumber', '');
    }

    if (mounted) {
      setState(() {
        OrderController.firstNameController.text = box.get('firstName');
        OrderController.emailAdultController.text = box.get('email');
        OrderController.lastNameController.text = box.get('lastName');
        OrderController.dateOfBirth.value = box.get('dateOfBirth');
        OrderController.countryCallingCodeAdultController.text =
            box.get('countryCallingCode');
        OrderController.mobilePhoneNumberAdultController.text =
            box.get('mobilePhoneNumber');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back(result: {
              'firstName': OrderController.firstNameController.text,
              'email': OrderController.emailAdultController.text,
              'lastName': OrderController.lastNameController.text,
              'dateOfBirth': OrderController.dateOfBirth.value,
              'countryCallingCode':
                  OrderController.countryCallingCodeAdultController.text,
              'mobilePhoneNumber':
                  OrderController.mobilePhoneNumberAdultController.text,
            });
          },
        ),
        title: Text(
            "Add Adult ${widget.index != null ? widget.index! + 1 : 1} Details"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                color: const Color(0xfffff8e6),
                child:  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          width: 250,
                          child: Text(
                            "Please make sure your information matches your government-issued identification.".tr,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.to(
                        () => ScanIDScreen(travelerIndex: widget.index ?? 0));
                  },
                  icon: const Icon(
                    Icons.document_scanner_outlined,
                    color: Colors.white,
                  ),
                  label:  Text(
                    "Scan ID to add traveller".tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(300, 50),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "Use Tour passport or GCC National ID to quickly and securely auto fill traveller details ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) {
                  return MaterialButton(
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      var box = await Hive.openBox('travelerDetails');
                      box.clear();
                    },
                    child: Text(details[index]),
                  );
                }),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "First name*",
                controller: OrderController.firstNameController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Email",
                controller: OrderController.emailAdultController,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Optional",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Last name*",
                controller: OrderController.lastNameController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "CountryCallingCode",
                controller: OrderController.countryCallingCodeAdultController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "MobilePhoneNumber",
                controller: OrderController.mobilePhoneNumberAdultController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Date of Birth*',
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    OrderController.dateOfBirth.value =
                        DateFormat('yyyy-MM-dd').format(picked);
                  }
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 60,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              if (OrderController.firstNameController.text.isEmpty ||
                  OrderController.lastNameController.text.isEmpty ||
                  OrderController.dateOfBirth.value.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Please fill in all required fields including Date of Birth',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              final travelerDetails = {
                'id':
                    widget.index != null ? (widget.index! + 1).toString() : "1",
                'dateOfBirth': OrderController.dateOfBirth.value,
                'name': {
                  'firstName': OrderController.firstNameController.text,
                  'lastName': OrderController.lastNameController.text
                },
                'contact': {
                  'emailAddress': OrderController.emailAdultController.text,
                  'phones': [
                    {
                      'deviceType': 'MOBILE',
                      'countryCallingCode': OrderController
                          .countryCallingCodeAdultController.text
                          .replaceAll("+", ""),
                      'number':
                          OrderController.mobilePhoneNumberAdultController.text
                    }
                  ]
                }
              };

              if (widget.index != null) {
                offersController.updateTraveler(widget.index!, travelerDetails);
              } else {
                offersController.addTraveler(travelerDetails);
              }

              _saveDataToHive();
              Get.back(result: {
                'firstName': OrderController.firstNameController.text,
                'email': OrderController.emailAdultController.text,
                'lastName': OrderController.lastNameController.text,
                'dateOfBirth': OrderController.dateOfBirth.value,
                'countryCallingCode':
                    OrderController.countryCallingCodeAdultController.text,
                'mobilePhoneNumber':
                    OrderController.mobilePhoneNumberAdultController.text,
              });
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 50), backgroundColor: Colors.teal),
            child: Text(
              "Set as Adult ${widget.index != null ? widget.index! + 1 : 1}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _saveDataToHive() async {
    var box = await Hive.openBox('travelerDetails');
    await box.put('firstName', OrderController.firstNameController.text);
    await box.put('email', OrderController.emailAdultController.text);
    await box.put('lastName', OrderController.lastNameController.text);
    await box.put('dateOfBirth', OrderController.dateOfBirth.value);
    await box.put('countryCallingCode',
        OrderController.countryCallingCodeAdultController.text);
    await box.put('mobilePhoneNumber',
        OrderController.mobilePhoneNumberAdultController.text);
  }
}
