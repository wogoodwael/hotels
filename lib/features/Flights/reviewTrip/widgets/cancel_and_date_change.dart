import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'allowance_item.dart';

class CancelAndDateChange extends StatelessWidget {
  const CancelAndDateChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.grey)),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              children: [
                Text('cancel& date change'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(
                  Icons.info_outline_rounded,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 12),
            AllowanceItem(
              label: 'Refundable with fees',
              pieces: '',
              icon: Icons.attach_money_sharp,
              color: Colors.blue.withOpacity(.5),
            ),
            AllowanceItem(
              label: 'changeable with fees',
              pieces: '',
              icon: Icons.attach_money_sharp,
              color: Colors.blue.withOpacity(.5),
            ),
            const SizedBox(
              height: 10,
            ),
            AllowanceItem(
              label: 'Refund to wallet within 24h (optional)',
              pieces: '',
              icon: Icons.attach_money,
              color: Colors.green.withOpacity(.7),
            ),
          ],
        ),
      ),
    );
  }
}
