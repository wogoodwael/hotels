import 'package:flutter/material.dart';

class ToPaidListTile extends StatelessWidget {
  const ToPaidListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text(
        'Total to be paid ',
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      subtitle: Text(
        "SAR 8,611.84",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: Text(
          "VIEW BOOKING SUMMARY",
          style: TextStyle(
              color: Colors.teal, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
