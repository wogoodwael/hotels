import 'package:flights/features/Flights/payments/presentation/pay_using_points.dart';
import 'package:flights/features/Flights/payments/presentation/payment_view.dart';
import 'package:flights/features/Flights/payments/presentation/widgets/cards_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPaymentMethodScreen extends StatelessWidget {
  const SelectPaymentMethodScreen({super.key});

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
        title: const Text(
          "Select payment method",
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.credit_card, color: Colors.teal),
              title: const Text("Credit or debit card"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.to(() => const PaymentScreen());
              },
            ),
            const Divider(),
            ListTile(
              subtitleTextStyle: const TextStyle(color: Colors.grey),
              leading: const Icon(Icons.payment, color: Colors.teal),
              title: const Text("Pay in installments"),
              subtitle: const Text("For bookings worth SAR 1,000.00 or more"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.to(() => const PaymentScreen());
              },
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.teal),
              title: Text("My Wallet"),
              subtitle: Text("No balance available"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.loyalty, color: Colors.teal),
              title: const Text("Pay using Qitaf points"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.to(() =>
                    const PayUsingPoints(title: 'Pay using Qitaf points '));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.card_giftcard, color: Colors.teal),
              title: const Text("Pay using mokafaa points"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.to(() =>
                    const PayUsingPoints(title: 'Pay using mokafaa points'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Voucher codes cannot be combined with wallet points or \n rewards from loyalty programmes ",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      bottomSheet: Container(
          width: MediaQuery.sizeOf(context).width,
          height: 70,
          color: Colors.white,
          child: const CardsRow()),
    );
  }
}
