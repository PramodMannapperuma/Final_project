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
  String licenseNumber = 'XYZ-123456'; // Replace with actual license number
  DateTime issueDate = DateTime.now(); // Replace with actual issue date
  double zoomScale = 1.0;

  Future<void> fetchLicenseData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('licenses')
          .where('userEmail', isEqualTo: user.email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        Map<String, dynamic> licenseData = snapshot.docs.first.data();
        setState(() {
          licenseNumber = licenseData['licenseNumber'] ?? 'XYZ-123456';
          issueDate = licenseData['issueDate']?.toDate() ?? DateTime.now();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLicenseData();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(issueDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Revenue License'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                    Text('Revenue License',style: TextStyle(fontSize: 30),),
                    Text(
                      'License No: $licenseNumber',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Issue Date: $formattedDate'),
                        Text('Expiration : 2025-04-29')
                      ],
                    ),
                    SizedBox(height: 5),
                    // Add other license details here based on fetched data
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