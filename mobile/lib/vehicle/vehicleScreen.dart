import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/repair/repair_details.dart';
import 'package:mobile/screens/profile_edit.dart';
import 'package:mobile/vehicle/vehicleDetails.dart';
import '../screens/profile.dart';
import 'EditVehicleDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  String? _displayedImage;

  @override
  void initState() {
    super.initState();
    fetchImageFromFirebase();
  }

  Future<Map<String, dynamic>?> fetchImageFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('userEmail', isEqualTo: user.email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        Map<String, dynamic> vehicleData = snapshot.docs.first.data();
        var imageUrl = vehicleData['imageUrls'];
        if (imageUrl is List && imageUrl.isNotEmpty) {
          setState(() {
            _displayedImage = imageUrl.first; // Using the first URL from the list
          });
        } else if (imageUrl is String) {
          setState(() {
            _displayedImage = imageUrl;
          });
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _displayedImage != null
                ? CircleAvatar(
              backgroundImage: NetworkImage(_displayedImage!),
              radius: 60,
              // Add onTap to change image
              // onTap: () => bottomSheet(),
            )
                : const CircularProgressIndicator(), // Show loading indicator while image is being fetched
            const SizedBox(height: 10),
            Text(
              "Shelby GT500",
              style: Theme.of(context).textTheme.headline6,
            ),
            FutureBuilder<Map<String, dynamic>?>(
                future: fetchUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator while waiting
                  } else if (snapshot.hasError) {
                    return Text(
                        "Error: ${snapshot.error}"); // Show error message
                  } else if (snapshot.hasData) {
                    String email = snapshot.data!['email'] ?? 'No email found';
                    return Text(
                      "$email",
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  } else {
                    return Text("No user data available");
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
            ),
            ProfileMenuWidget(
              title: "Details",
              icon: Icons.car_crash,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VehicleDetails()),
                );
              },
            ),
            ProfileMenuWidget(
              title: "Settings",
              icon: Icons.settings,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditVehicleDetails()),
                );
              },
            ),
            ProfileMenuWidget(
              title: "Repair Details",
              icon: Icons.tire_repair_sharp,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RepairDetails(),
                  ),
                );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ProfileMenuWidget(
              title: "Info",
              icon: Icons.info,
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Widget bottomSheet() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //         topRight: Radius.circular(18.0),
  //         topLeft: Radius.circular(18.0),
  //         bottomRight: Radius.circular(18.0),
  //         bottomLeft: Radius.circular(18.0),
  //       ),
  //     ),
  //     padding: const EdgeInsets.only(top: 9),
  //     height: 180,
  //     width: MediaQuery.of(context).size.width,
  //     margin: const EdgeInsets.only(bottom: 9, left: 4, top: 0, right: 4),
  //     child: Column(
  //       children: [
  //         const Text(
  //           "Choose Vehicle Photo",
  //           style: TextStyle(fontSize: 20.0),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             TextButton.icon(
  //               onPressed: () {
  //                 takePhoto(ImageSource.camera);
  //               },
  //               icon: const Icon(Icons.camera, color: Colors.black87),
  //               label: const Text(
  //                 "Camera",
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.w400, color: Colors.black87),
  //               ),
  //             ),
  //             TextButton.icon(
  //               onPressed: () {
  //                 takePhoto(ImageSource.gallery);
  //               },
  //               icon: const Icon(
  //                 Icons.image,
  //                 color: Colors.black87,
  //               ),
  //               label: const Text(
  //                 "Gallery",
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.w400, color: Colors.black87),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextButton.icon(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               icon: const Icon(
  //                 Icons.cancel,
  //                 color: Colors.red,
  //               ),
  //               label: const Text(
  //                 "Cancel",
  //                 style:
  //                     TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await _picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = pickedFile;
  //     });
  //     Navigator.pop(context); // Close the bottom sheet after selecting an image
  //   }
  // }
}
