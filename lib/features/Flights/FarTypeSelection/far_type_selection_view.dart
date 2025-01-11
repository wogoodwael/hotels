// import 'package:flights/features/FarTypeSelection/data/models/upselling_model.dart';
// import 'package:flutter/material.dart';

// import 'fare_option.dart';

// class FareTypeSelection extends StatelessWidget {
//   const FareTypeSelection({
//     super.key,
//     required this.lenght,
//     required this.travelerPricings, 
//   });
//   final int lenght;
//   final List<TravelerPricingUpSelling> travelerPricings;

//   @override
//   Widget build(BuildContext context) {
//     print(travelerPricings.length);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('Select fare type'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(travelerPricings.length, (int index) {
//               return FareOption(
//                 name: travelerPricings[index].fareOption ?? "",
//                 price: travelerPricings[index].price?.base ?? "",
//                 isSelected: true,
//                 length: lenght, 
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
