import 'package:flutter/material.dart';

import '../../../../../shared/widgets/custom_text_field.dart';
import 'phone_number_container.dart';

class ContactDetailsContainer extends StatelessWidget {
  const ContactDetailsContainer({
    super.key, required this.postalCodeController, required this.countryCodeController, required this.countryCodePhoneController, required this.emailController, required this.phoneNumberController, required this.mobilePhoneNumberController, required this.invoiceAddressController, required this.mailingAddressController,
  });
  final TextEditingController postalCodeController;
  final TextEditingController countryCodeController;
  final TextEditingController countryCodePhoneController;

  final TextEditingController emailController;  
  final TextEditingController phoneNumberController;
  final TextEditingController mobilePhoneNumberController;
  final TextEditingController invoiceAddressController;
  final TextEditingController mailingAddressController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: .9 * MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            CustomTextField(labelText: "Postal Code*", controller: postalCodeController),
            const SizedBox(height: 16),
            CustomTextField(labelText: "Country Code*", controller: countryCodeController),
            const SizedBox(height: 16),
            CustomTextField(labelText: "Email*", controller: emailController),
            const Text(
              "Your Purchased tickets will be sent to this email ",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
             Column(
              children: [PhoneNumberContainer(controller: countryCodePhoneController, phoneNumberController: phoneNumberController )],
            ),
          ],
        ),
      ),
    );
  }
}
