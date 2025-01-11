import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.labelText,
      this.controller,
      this.readOnly,
      this.onTap,
      this.maxLength,
      this.textCapitalization,
      this.onChanged,
      this.validator});
  final String labelText;
  TextEditingController? controller;
  bool? readOnly;
  Function()? onTap;
  int? maxLength;
  TextCapitalization? textCapitalization;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      onTap: onTap,
      maxLength: maxLength,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 17),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(.7)))),
    );
  }
}
