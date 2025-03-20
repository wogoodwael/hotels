import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecurityContainer extends StatelessWidget {
  const SecurityContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: .9 * MediaQuery.sizeOf(context).width,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(.1),
            borderRadius: BorderRadius.circular(10)),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.security,
              color: Colors.grey,
            ),
            Text(
                "Your transactions are 100% safe with \n us and we protect your information".tr)
          ],
        ),
      ),
    );
  }
}
