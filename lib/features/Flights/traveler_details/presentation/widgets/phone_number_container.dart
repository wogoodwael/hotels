import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PhoneNumberContainer extends StatelessWidget {
  const PhoneNumberContainer({
    super.key,  this.controller,  this.phoneNumberController,
  });
  final TextEditingController ?controller;
  final TextEditingController ?phoneNumberController;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       Expanded(
                flex: 1,
                child: Container(
                  width: 200,
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          controller?.text = country.phoneCode;
                          print('Selected country: ${country.phoneCode}');
                        },
                      );
                    },
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller?.text ?? '+966',
                          style: TextStyle(fontSize: 17),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            
      SizedBox(width: 10),
    
        Expanded(
          flex: 2,
          child: TextField(
            controller: phoneNumberController,
            decoration: InputDecoration(
              labelText: "Mobile number *",
              labelStyle: TextStyle(color: Colors.grey[700], fontSize: 17),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.7)),
              ),
            ),
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }
}
