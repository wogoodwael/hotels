import 'package:flutter/material.dart';

class AddCardDetails extends StatelessWidget {
  const AddCardDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.track_changes_outlined, color: Colors.teal),
        label: const Text(
          "Tap to add your card details",
          style: TextStyle(color: Colors.teal),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          minimumSize: const Size(300, 45),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.teal)),
        ),
      ),
    );
  }
}
