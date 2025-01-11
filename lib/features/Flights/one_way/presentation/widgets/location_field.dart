import 'package:flutter/material.dart';


class LocationField extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData icon;
  final VoidCallback onTap;
  const LocationField({
    super.key,
    required this.title, 
    required this.hintText,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
  
    return SizedBox(
      width: .7 * MediaQuery.of(context).size.width,
      height: 40,
      child: TextField(
        readOnly: true,
        onTap: onTap,
        controller: TextEditingController(text: hintText),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 0),
          labelText: title,
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 115, 67, 67),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
