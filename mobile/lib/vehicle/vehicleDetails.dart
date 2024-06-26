import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile/repair/repair_details.dart';
import 'package:mobile/vehicle/report_request.dart';
import '../screens/profile_view.dart';
import '../accident/accident_detail.dart';
import 'get_vehidata.dart';


class VehicleDetails extends StatefulWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  Future<Map<String, dynamic>?> checkForVehicleData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('userEmail', isEqualTo: user.email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data() as Map<String,
            dynamic>; // Assuming this contains all necessary vehicle data
      }
    }
    return null; // No vehicle data or user not logged in
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: checkForVehicleData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            // Data exists, proceed to show vehicle details
            return buildVehicleDetailsPage(context, snapshot.data!);
          } else {
            // No data exists, navigate to VehicleDetailsForm to add new vehicle
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => VehicleDetailsForm()),
              );
            });
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        }
        // Show loading indicator while checking data
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildVehicleDetailsPage(
      BuildContext context, Map<String, dynamic> vehicleData) {
    // String encryptedVin = vehicleData['vin'] ?? 'N/A';
    // String decryptedVin = 'N/A';
    //
    // if (encryptedVin != 'N/A') {
    //   decryptedVin = EncryptionService.decryptText(encryptedVin);
    // }
    var imageUrl = vehicleData['imageUrls'];
    String displayedImage;

    if (imageUrl is List && imageUrl.isNotEmpty) {
      displayedImage = imageUrl
          .first; // Assuming the list contains string URLs and you want the first one
    } else if (imageUrl is String) {
      displayedImage = imageUrl;
    } else {
      displayedImage =
          'assets/Images/acci.jpg'; // Default image if no URL is provided
    }
    List<String> imageUrls = List<String>.from(vehicleData['imageUrls'] ?? []);
    List<Widget> imageSliders = imageUrls
        .map((url) => Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
              ),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Profile'),
        centerTitle: true,
        // actions: [
          // IconButton(
          //   icon: Icon(Icons.edit),
          //   onPressed: () {
          //     String vehicleId =
          //         'your-vehicle-id-here'; // Replace this with actual vehicle ID
          //
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => VehicleEdit(),
          //       ),
          //     );
          //   },
          // ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: displayedImage != null
                      ? NetworkImage(displayedImage)
                      : const AssetImage("assets/Images/acci.jpg") as ImageProvider,
                  radius: 60,
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
                        // Open edit modal or bottom sheet
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
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Shelby GT500',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Column(
                children: [
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'Make',
                  value: '${vehicleData['make'] ?? 'N/A'}',
                ),
                ProfileDetailRow(
                  title: 'Model',
                  value: '${vehicleData['model'] ?? 'N/A'}',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                  title: 'Year',
                  value: '${vehicleData['year'] ?? 'N/A'}',
                ),
                ProfileDetailRow(
                  title: 'Color',
                  value: '${vehicleData['color'] ?? 'N/A'}',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileDetailColumn(
                    title: 'Vehicle Identification Number (VIN)',
                    value: '${vehicleData['vin'] ?? 'N/A'}'),
              ],
            ),
            ProfileDetailColumn(
              title: 'Liscense Plate Number',
              value: '${vehicleData['licensePlateNumber'] ?? 'N/A'}',
            ),
            ProfileDetailColumn(
              title: 'Engine Type',
              value: '${vehicleData['engineType'] ?? 'N/A'}',
            ),
            ProfileDetailColumn(
              title: 'Fuel Type',
              value: '${vehicleData['fuelType'] ?? 'N/A'}',
            ),
            ProfileDetailColumn(
              title: 'Miles',
              value: '${vehicleData['miles'] ?? "N/A"}',
            ),
            ProfileDetailColumn(
              title: 'Horse Power',
              value: '${vehicleData['horsePower'] ?? 'N/A'}',
            ),
            ProfileDetailColumn(
              title: 'Transmission',
              value: '${vehicleData['transmission'] ?? 'N/A'}',
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                height: 600,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 1.0,
              ),
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RepairDetails()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        Icons.settings_outlined,
                        size: 30, // Adjust the icon size as needed
                      ),
                    ),
                    Text(
                      "Repair Details",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccidentDetails()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        Icons.car_crash_outlined,
                        size: 30, // Adjust the icon size as needed
                      ),
                    ),
                    Text(
                      "Accident Details",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RquestReport()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        Icons.library_books_sharp,
                        size: 30, // Adjust the icon size as needed
                      ),
                    ),
                    Text(
                      "Request a Report",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width / 1.1,
              child: const Divider(
                thickness: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
