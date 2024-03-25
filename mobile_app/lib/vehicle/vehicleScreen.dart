import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/vehicle/EditVehicleDetails.dart';
import 'package:mobile_app/vehicle/repair_details.dart';
import 'package:mobile_app/vehicle/vehicleDetails.dart';

import '../auth/login.dart';
import '../screens/profile.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

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
            Stack(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: _imageFile != null
                      ? FileImage(File(_imageFile!.path))
                      : const AssetImage("assets/Images/well.jpg")
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 2,
                  right: 4,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blueGrey.withOpacity(0.8),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((build) => bottomSheet()),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Shelby GT500",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "JohnDoe69@gmail.com",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
                  MaterialPageRoute(builder: (context) => const EditVehicle()),
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

  Widget bottomSheet() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18.0),
          topLeft: Radius.circular(18.0),
          bottomRight: Radius.circular(18.0),
          bottomLeft: Radius.circular(18.0),
        ),
      ),
      padding: const EdgeInsets.only(top: 9),
      height: 180,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 9, left: 4, top: 0, right: 4),
      child: Column(
        children: [
          const Text(
            "Choose Vehicle Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: const Icon(Icons.camera, color: Colors.black87),
                label: const Text(
                  "Camera",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black87),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.black87,
                ),
                label: const Text(
                  "Gallery",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black87),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                label: const Text(
                  "Cancel",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
      Navigator.pop(context); // Close the bottom sheet after selecting an image
    }
  }
}
