// import 'package:flights/features/FarTypeSelection/domain/upselling_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// //*need to refactor this
// class FareOption extends StatelessWidget {
//   final String name;
//   final String price;
//   final bool isSelected;
//   final int length;
 
 
//   FareOption({
//     super.key,
//     required this.name,
//     required this.price,
//     required this.isSelected,
//     required this.length,
   
   
//   });
//   final UpsellingController upsellingController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     print(upsellingController.upsellingResponse.value.data?.data?.length);
//     return Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//             border: Border.all(color: Colors.grey.withOpacity(.4))),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               color: Colors.grey.withOpacity(.1),
//               height: 70,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16.0,
//                           ),
//                         ),
//                         const SizedBox(height: 4.0),
//                         Text(
//                           price,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (isSelected)
//                       ElevatedButton(
//                         onPressed: () {
                        
//                         },
//                         style: ElevatedButton.styleFrom(
//                           elevation: 0,
//                           backgroundColor: Colors.red,
//                           overlayColor: Colors.white,
//                         ),
//                         child: const Text(
//                           'Select',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 24.0),
//                   const Text(
//                     'Baggage allowance',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8.0),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: length,
//                     itemBuilder: (context, index) {
//                       final amenities = upsellingController
//                           .upsellingResponse
//                           .value
//                           .data
//                           ?.data
//                           ?.first
//                           .travelerPricings
//                           ?.first
//                           .fareDetailsBySegment
//                           ?.first
//                           .amenities;

//                       if (amenities == null || amenities.isEmpty) {
//                         return const ListTile(
//                           title: Text("No amenities available"),
//                         );
//                       }

//                       return ListTile(
//                         leading:
//                             Icon(Icons.check_circle, color: Colors.green[200]),
//                         title: Text(
//                             amenities[index].description ?? "No description"),
//                         subtitle: Text(amenities[index].code ?? "No code"),
//                       );
//                     },
//                   ),
//                   const Divider(
//                     height: 30,
//                   ),
//                   const Text(
//                     'Cancel & date change',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                               width: 20,
//                               height: 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.blue[100],
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: const Icon(Icons.attach_money,
//                                   size: 15, color: Colors.blue)),
//                           const SizedBox(width: 8.0),
//                           const Text('Refundable with fees'),
//                         ],
//                       ),
//                       const SizedBox(height: 8.0),
//                       Row(
//                         children: [
//                           Container(
//                               width: 20,
//                               height: 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.blue[100],
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: const Icon(Icons.attach_money,
//                                   size: 15, color: Colors.blue)),
//                           const SizedBox(width: 8.0),
//                           const Text('Changeable with fees'),
//                         ],
//                       ),
//                       const SizedBox(height: 8.0),
//                       Row(
//                         children: [
//                           Container(
//                               width: 20,
//                               height: 20,
//                               decoration: BoxDecoration(
//                                   color: Colors.green[100],
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: const Icon(Icons.attach_money,
//                                   size: 15, color: Colors.green)),
//                           const SizedBox(width: 8.0),
//                           const Text('Refund to wallet within 24h (optional)'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
