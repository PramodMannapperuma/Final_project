// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../screens/profile_view.dart';
//
//
// class RepairInfo extends StatefulWidget {
//   final String repairId;
//
//   const RepairInfo({Key? key, required this.repairId}) : super(key: key);
//
//   @override
//   State<RepairInfo> createState() => _RepairInfoState();
// }
// Future<Map<String, dynamic>?> fetchRepairDetails() async {
//   // User? user = FirebaseAuth.instance.currentUser;
//   if (repairId != null) {
//     DocumentSnapshot userDoc = await FirebaseFirestore.instance
//         .collection('repairs')
//         .doc(repairId)
//         .get();
//     return userDoc.data() as Map<String, dynamic>?;
//   }
//   return null;
// }
//
// class _RepairInfoState extends State<RepairInfo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Repair Details"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Hello,",
//                     style: TextStyle(fontSize: 40),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Pramod Mannapperuma",
//                     style: TextStyle(fontSize: 30),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Tyre Chnage,",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               // Add the ImageSlider widget here
//               CarouselSlider(
//                 items: [
//                   Image.asset('assets/Images/tyre1.png'),
//                   Image.asset('assets/Images/tyre.jpg'),
//                   Image.asset('assets/Images/tyre-change.jpg'),
//                   // Add more images as needed
//                 ],
//                 options: CarouselOptions(
//                   height: 300,
//                   enlargeCenterPage: true,
//                   autoPlay: true,
//                   aspectRatio: 16 / 9,
//                   autoPlayCurve: Curves.fastOutSlowIn,
//                   enableInfiniteScroll: true,
//                   autoPlayAnimationDuration: Duration(milliseconds: 800),
//                   viewportFraction: 0.8,
//                 ),
//               ),
//               Text(
//                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               const ProfileDetailColumn(
//                   title: 'Date & Time', value: '2023-03-03 | 10.38 A.M.'),
//               const ProfileDetailColumn(
//                   title: 'Location', value: 'Lotus Tower'),
//               const ProfileDetailColumn(
//                   title: 'Repairs ',
//                   value: 'Changed Tyres | Checked Alignments '),
//               const ProfileDetailColumn(
//                   title: 'Description Of Repair',
//                   value:
//                   'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }