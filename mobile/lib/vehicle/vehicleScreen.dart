import 'package:flutter/material.dart';
import 'package:mobile/repair/repair_details.dart';
import 'package:mobile/vehicle/vehicleDetails.dart';
import '../screens/profile.dart';
import 'EditVehicleDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  String? _displayedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchImageFromFirebase();
  }

  Future<void> fetchImageFromFirebase() async {
    User? user = _auth.currentUser;
    if (user?.email != null) {
      var snapshot = await _firestore.collection('vehicles')
          .where('userEmail', isEqualTo: user!.email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var vehicleData = snapshot.docs.first.data();
        var imageUrl = vehicleData['imageUrls'];
        updateDisplayedImage(imageUrl);
      }
    }
  }

  void updateDisplayedImage(dynamic imageUrl) {
    if (imageUrl is List && imageUrl.isNotEmpty) {
      _setDisplayedImage(imageUrl.first);
    } else if (imageUrl is String) {
      _setDisplayedImage(imageUrl);
    }
  }

  void _setDisplayedImage(String imageUrl) {
    setState(() {
      _displayedImage = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle'),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          _buildImageWidget(),
          const SizedBox(height: 10),
          const Text("Shelby GT500", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          ..._buildProfileMenuWidgets(),
          const Divider(thickness: 1),
          ProfileMenuWidget(
            title: "Info",
            icon: Icons.info,
            onPress: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    return _displayedImage != null
        ? CircleAvatar(
      backgroundImage: NetworkImage(_displayedImage!),
      radius: 60,
    )
        : const CircularProgressIndicator();
  }

  List<Widget> _buildProfileMenuWidgets() {
    return [
      ProfileMenuWidget(
        title: "Details",
        icon: Icons.car_crash,
        onPress: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VehicleDetails()),
        ),
      ),
      ProfileMenuWidget(
        title: "Settings",
        icon: Icons.settings,
        onPress: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditVehicleDetails()),
        ),
      ),
      ProfileMenuWidget(
        title: "Repair Details",
        icon: Icons.tire_repair_sharp,
        onPress: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RepairDetails()),
        ),
      ),
    ];
  }
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

