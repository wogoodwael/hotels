import 'package:flutter/material.dart';

class ContainerBottomNavBar extends StatelessWidget {
  const ContainerBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 50,
      alignment: Alignment.bottomCenter,
      child: MaterialButton(
        elevation: 0,
        height: 50,
        minWidth: MediaQuery.of(context).size.width * 0.7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.red,
        onPressed: () {},
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            Text(
              'Search flights',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
