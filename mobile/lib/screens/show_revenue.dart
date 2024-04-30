import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShowRevenue extends StatefulWidget {
  const ShowRevenue({Key? key}) : super(key: key);

  @override
  State<ShowRevenue> createState() => _ShowRevenueState();
}

class _ShowRevenueState extends State<ShowRevenue> {
  late String licenseNumber = 'Loading...';
  late String formattedDate = 'Loading...';
  late String collectionId = 'Loading...';
  Map<String, dynamic> vehicleDetails = {};
  late double zoomScale;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLicenseData();
    zoomScale = 1.0;
  }

  Future<void> fetchLicenseData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email != null) {
        var vehicleSnapshot = await FirebaseFirestore.instance
            .collection('vehicles')
            .where('userEmail', isEqualTo: user.email)
            .limit(1)
            .get();

        if (vehicleSnapshot.docs.isNotEmpty) {
          var vehicleData = vehicleSnapshot.docs.first.data();
          setState(() {
            collectionId = vehicleData['collectionId'] ?? 'Not Available';
          });

          var licenseSnapshot = await FirebaseFirestore.instance
              .collection('licenses')
              .doc(collectionId)
              .get();

          if (licenseSnapshot.exists) {
            var licenseData = licenseSnapshot.data();
            setState(() {
              licenseNumber = licenseData?['licenseNumber'] ?? 'Not Available';
              vehicleDetails = licenseData?['vehicleDetails'] ?? {};
              formattedDate =
                  DateFormat('yyyy-MM-dd').format(DateTime.now());
              isLoading = false; // Data fetched, set loading to false
            });
          } else {
            print('License document not found');
          }
        } else {
          print('No vehicle data found for user');
        }
      } else {
        print('User not logged in or email not available');
      }
    } catch (error) {
      print('Error fetching data: $error');
      // Handle error (e.g., show error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revenue License'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: GestureDetector(
            onScaleUpdate: (ScaleUpdateDetails details) {
              setState(() {
                zoomScale = details.scale;
              });
            },
            child: Transform.scale(
              scale: zoomScale,
              child: Container(
                width: 550, // Adjust width as needed
                height: 700, // Adjust height as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                  color: Colors.purpleAccent, // Change color as needed
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Revenue License', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                    Text(
                      'License No: $licenseNumber',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Issue Date: ${vehicleDetails[''] ?? 'N/A' }'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Issue Date: $formattedDate'),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  ' $collectionId',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 0),
                    // Add other license details here based on fetched data
                    SizedBox(height: 5),
                    Text(
                      'Class of Vehicle, Fuel Type, and Vehicle No:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${vehicleDetails['make'] ?? 'N/A'}/${vehicleDetails['fuelType']}/${vehicleDetails['licensePlateNumber']}',
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Owner Information',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('HP: ${vehicleDetails['horsePower']}'),
                        Text('LPN: ${vehicleDetails['licensePlateNumber']}'),
                        Text('VIN: ${vehicleDetails['vin']}'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Vehicle Information',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Make: ${vehicleDetails['make']}'),
                        Text('Model: ${vehicleDetails['model']}'),
                      ],
                    ),
                    Text(
                      'Fee Information',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Make: ${vehicleDetails['make']}'),
                        Text('Model: ${vehicleDetails['model']}'),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
