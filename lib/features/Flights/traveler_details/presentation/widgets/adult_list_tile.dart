import 'package:flutter/material.dart';

import 'adult_container.dart';

class AdultListTile extends StatelessWidget {
  const AdultListTile({
    super.key,
    required this.widget,
  });

  final AdultContainer widget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Radio(
        value: 0,
        groupValue: 1,
        onChanged: (int? v) {},
      ),
      title: Text(
        widget.firstName != null
            ? "${widget.firstName} ${widget.email ?? ''} ${widget.lastName}"
            : "No traveller added",
        style: const TextStyle(fontSize: 14),
      ),
      subtitle: Text(
        widget.dateOfBirth != null
            ? "${widget.dateOfBirth!.toLocal()}".split(' ')[0]
            : "Date of Birth not set",
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
