import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile/repair/repair_details.dart';
import 'package:mobile/vehicle/report_request.dart';
import 'package:mobile/vehicle/vehicle_edit.dart';
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
        return snapshot.docs.first.data() as Map<String, dynamic>;  // Assuming this contains all necessary vehicle data
      }
    }
    return null;  // No vehicle data or user not logged in
  }
  // Future<String?> fetchVehicleImageUrl() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null && user.email != null) {
  //     var snapshot = await FirebaseFirestore.instance
  //         .collection('vehicles')
  //         .where('userEmail', isEqualTo: user.email)
  //         .limit(1)
  //         .get();
  //
  //     if (snapshot.docs.isNotEmpty) {
  //       return snapshot.docs.first.data()['imageUrl'];  // Assuming 'imageUrl' is the field name
  //     }
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: checkForVehicleData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            // Data exists, proceed to show vehicle details
            return buildVehicleDetailsPage(context,snapshot.data!);
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


  Widget buildVehicleDetailsPage(BuildContext context, Map<String, dynamic> vehicleData) {
    var imageUrl = vehicleData['imageUrls'];
    String displayedImage;

    if (imageUrl is List && imageUrl.isNotEmpty) {
      displayedImage = imageUrl.first;  // Assuming the list contains string URLs and you want the first one
    } else if (imageUrl is String) {
      displayedImage = imageUrl;
    } else {
      displayedImage = 'assets/Images/well.jpg';  // Default image if no URL is provided
    }
    List<String> imageUrls = List<String>.from(vehicleData['imageUrls'] ?? []);
    List<Widget> imageSliders = imageUrls.map((url) => Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
      ),
    )).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              String vehicleId = 'your-vehicle-id-here'; // Replace this with actual vehicle ID

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VehicleEdit(vehicleId: vehicleId),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Background cover photo
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/Images/cv.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Circle avatar
                  Positioned(
                    bottom: 0, // Adjust the bottom position as needed
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(displayedImage),
                      radius: 60,
                    ),
                  ),
                ],
              ),
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
                    style: TextStyle(fontSize: 16, ),),
                  Divider(
                    thickness: 1.0,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileDetailColumn(
                  title: 'Vehicle Identification Number (VIN)',
                value: '${vehicleData['vin'] ?? 'N/A'}'),

              ],
            ),
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

            GestureDetector(
              onTap: () {
                // Handle tapping on Miles
              },
              child: ProfileDetailColumn(
                title: 'Liscense Plate Number',
                value: '${vehicleData['licensePlateNumber'] ?? 'N/A'}',
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle tapping on Services
              },
              child: ProfileDetailColumn(
                title: 'Engine Type',
                value: '${vehicleData['engineType'] ?? 'N/A'}',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileDetails(),),);
              },
              child: ProfileDetailColumn(
                title: 'Fuel Type',
                value: '${vehicleData['fuelType'] ?? 'N/A'}',
              ),
            ),
            ProfileDetailColumn(
              title: 'Horse Power',
              value: '${vehicleData['horsePower'] ?? 'N/A'}',
            ),
            ProfileDetailColumn(
              title: 'Transmission',
              value: '${vehicleData['transmission'] ?? 'N/A'}',
            ),
            SizedBox(height: 10),
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                height: 600,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                  MaterialPageRoute(builder: (context) => RepairDetails()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
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
              child: Divider(
                thickness: 1.0,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccidentDetails()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
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
              child: Divider(
                thickness: 1.0,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RquestReport()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
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

