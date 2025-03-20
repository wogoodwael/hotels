import 'package:flights/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/add_card_details.dart';
import 'widgets/cards_row.dart';
import 'widgets/pay_now_bottom_sheet.dart';
import 'widgets/security_container.dart';
import 'widgets/to-paid_list_tile.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        title:  Text(
          "Payment".tr,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const ToPaidListTile(),
              const Divider(thickness: 1),
              const SizedBox(height: 16),
              const SecurityContainer(),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                child: Text("Credit or debit card",
                    style: TextStyle(fontSize: 20)),
              ),
              const AddCardDetails(),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                child: CustomTextField(labelText: 'Card Number'),
              ),
              Row(
                children: [
                  Expanded(child: CustomTextField(labelText: 'MM')),
                  const SizedBox(width: 8),
                  Expanded(child: CustomTextField(labelText: 'YY')),
                  const SizedBox(width: 8),
                  Expanded(child: CustomTextField(labelText: 'CVV')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                child: CustomTextField(labelText: 'Name on card '),
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  const Text("Save card for future use"),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const CardsRow(),
            ],
          ),
        ),
      ),
      bottomSheet: const PayNowBottomSheet(),
    );
  }
}
