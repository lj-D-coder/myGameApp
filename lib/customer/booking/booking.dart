// import 'package:flutter/material.dart';

// class Booking extends StatefulWidget {
//   const Booking({super.key});

//   @override
//   State<Booking> createState() => _BookingState();
// }

// class _BookingState extends State<Booking> {
//   DateTime? userSelectedDay = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * .6,
//             width: MediaQuery.of(context).size.width,
//             child: ListView.builder(
//                 itemCount: 16,
//                 itemBuilder: (ctx, index) {
//                   return Container(
//                     margin:
//                         const EdgeInsets.only(left: 20, right: 15, bottom: 10),
//                     padding: const EdgeInsets.all(3),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: const Color.fromARGB(255, 49, 63, 91),
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     height: 140,
//                     child: Column(
//                       children: [
//                         const ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: Colors.purple,
//                             maxRadius: 20,
//                           ),
//                           subtitle: Text("Khuman Lampak Stadium"),
//                           title: Text(
//                             "The Imphal Football",
//                           ),
//                           trailing: Icon(Icons.pin_drop),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text("Scheduled",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .labelSmall!
//                                               .copyWith(
//                                                   color: Colors.grey.shade400)),
//                                       Text("10:00 am to 12:00 pm",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .labelSmall!
//                                               .copyWith(
//                                                   color: Colors.grey.shade400)),
//                                     ],
//                                   ),
//                                   const Spacer(),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       const Text("\u20B9 250"),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(5),
//                                                 color: Colors.white,
//                                               ),
//                                               alignment: Alignment.center,
//                                               height: 25,
//                                               width: 50,
//                                               child: Text(
//                                                 "Line Up",
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .labelSmall!
//                                                     .copyWith(
//                                                         color: Colors.black),
//                                               )),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(5),
//                                                 color: Colors.white,
//                                               ),
//                                               alignment: Alignment.center,
//                                               height: 25,
//                                               width: 50,
//                                               child: Text(
//                                                 "BUY",
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .labelSmall!
//                                                     .copyWith(
//                                                         color: Colors.black),
//                                               ))
//                                         ],
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }
