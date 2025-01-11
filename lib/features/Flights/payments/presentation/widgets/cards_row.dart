import 'package:flutter/material.dart';

class CardsRow extends StatelessWidget {
  const CardsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            "Cards accepted ",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            "assets/images/cards.png",
            width: 100,
          ),
        )
      ],
    );
  }
}
