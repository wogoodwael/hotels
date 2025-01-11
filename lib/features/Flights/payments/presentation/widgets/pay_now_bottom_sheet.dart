import 'package:flutter/material.dart';

class PayNowBottomSheet extends StatelessWidget {
  const PayNowBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 80,
      color: Colors.white,
      child: Column(
        children: [
          Divider(
            color: Colors.grey.withOpacity(.2),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 45),
                backgroundColor: Colors.green,
              ),
              icon: const Icon(
                Icons.lock_open_sharp,
                color: Colors.white,
              ),
              label: const Text(
                "Pay now ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
