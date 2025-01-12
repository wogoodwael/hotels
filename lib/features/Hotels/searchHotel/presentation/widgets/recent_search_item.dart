import 'package:flutter/material.dart';

class RecentSearchItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const RecentSearchItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: const Icon(Icons.close, color: Colors.black),
      onTap: () {},
    );
  }
}
