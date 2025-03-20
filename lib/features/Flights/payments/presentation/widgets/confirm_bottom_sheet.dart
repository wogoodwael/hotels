import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmBottomSheet extends StatelessWidget {
  const ConfirmBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 70,
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 10),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              maximumSize: const Size(400, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child:  Text(
              "Confirm".tr,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
      ),
    );
  }
}
