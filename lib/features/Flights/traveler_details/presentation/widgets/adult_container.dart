import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../adult_details.dart';
import 'adult_list_tile.dart';
import 'adults_added_details.dart';
import '../../../offers/domain/offers_controller.dart';

// ignore: must_be_immutable
class AdultContainer extends StatefulWidget {
  AdultContainer({
    super.key,
    this.firstName,
    this.email,
    this.lastName,
    this.dateOfBirth,
    this.countryCallingCode,
    this.mobilePhoneNumber,
    this.index = 1,
  });

  String? firstName;
  String? email;
  String? lastName;
  DateTime? dateOfBirth;
  String? countryCallingCode;
  String? mobilePhoneNumber;
  final int index;

  @override
  State<AdultContainer> createState() => _AdultContainerState();
}

class _AdultContainerState extends State<AdultContainer> {
  final OffersController offersController = Get.find<OffersController>();

  @override
  void initState() {
    super.initState();
    _loadTravelerData();
  }

  void _loadTravelerData() {
    if (widget.index < offersController.travelers.length) {
      final traveler = offersController.travelers[widget.index];
      setState(() {
        widget.firstName = traveler['name']['firstName'] ?? '';
        widget.lastName = traveler['name']['lastName'] ?? '';
        widget.email = traveler['contact']['emailAddress'] ?? '';
        widget.dateOfBirth = traveler['dateOfBirth'] != null
            ? DateTime.tryParse(traveler['dateOfBirth'])
            : null;
        widget.countryCallingCode =
            traveler['contact']['phones'][0]['countryCallingCode'] ?? '';
        widget.mobilePhoneNumber =
            traveler['contact']['phones'][0]['number'] ?? '';
      });
    } else {
      _loadDataFromHive();
    }
  }

  void _loadDataFromHive() async {
    var box = await Hive.openBox('travelerDetails');
    setState(() {
      widget.firstName = box.get('firstName', defaultValue: '') ?? '';
      widget.email = box.get('email', defaultValue: '') ?? '';
      widget.lastName = box.get('lastName', defaultValue: '') ?? '';

      String? storedDate = box.get('dateOfBirth');
      widget.dateOfBirth =
          storedDate != null ? DateTime.tryParse(storedDate) : null;

      widget.countryCallingCode =
          box.get('countryCallingCode', defaultValue: '') ?? '';
      widget.mobilePhoneNumber =
          box.get('mobilePhoneNumber', defaultValue: '') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(.3)),
            borderRadius: BorderRadius.circular(20)),
        width: .9 * width(context),
        height: widget.firstName != "" ? 300 : 125,
        child: Column(children: [
          Container(
            width: .9 * MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                      "${offersController.offers?.data.data[0].travelerPricings[widget.index].travelerType}"),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Get.to(() => AdultDetails(index: widget.index))!
                        .then((result) {
                      if (result != null) {
                        setState(() {
                          widget.firstName = result['firstName'];
                          widget.email = result['email'];
                          widget.lastName = result['lastName'];
                          widget.countryCallingCode =
                              result['countryCallingCode'];
                          widget.mobilePhoneNumber =
                              result['mobilePhoneNumber'];

                          var dob = result['dateOfBirth'];
                          if (dob is String) {
                            widget.dateOfBirth = DateTime.tryParse(dob);
                          } else if (dob is DateTime) {
                            widget.dateOfBirth = dob;
                          } else {
                            widget.dateOfBirth = null;
                          }
                        });
                      }
                    });
                  },
                  child: Text(
                    widget.firstName != ""
                        ? "Change/ add traveller".tr
                        : "Add a new traveller".tr,
                    style: const TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),
          AdultListTile(widget: widget),
          widget.firstName != "" ? const AdultAddedDetails() : const SizedBox()
        ]),
      ),
    );
  }
}
