import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/profile_view.dart';

class RepairInfo extends StatefulWidget {
  final String repairId;

  const RepairInfo({Key? key, required this.repairId}) : super(key: key);

  @override
  State<RepairInfo> createState() => _RepairInfoState();
}

class _RepairInfoState extends State<RepairInfo> {
  late Future<Map<String, dynamic>?> repairDetailsFuture;

  String formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  Future<Map<String, dynamic>?> fetchRepairDetails() async {
    DocumentSnapshot repairDoc = await FirebaseFirestore.instance
        .collection('repairs')
        .doc(widget.repairId)
        .get();
    if (repairDoc.exists) {
      return repairDoc.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Repair Details"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: fetchRepairDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData && snapshot.data != null) {
              final repairData = snapshot.data!;
              print("repair data print $repairData");

              List<String> imageUrls =
                  (repairData['imageUrls'] as List<dynamic>?)
                          ?.map((imageUrl) => imageUrl.toString())
                          .toList() ??
                      [];

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display repair details using the fetched data
                      Text(
                        repairData['repair'] ?? 'No Title',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 10),
                      Text(
                        repairData['description'] ?? 'No Description',
                        style: TextStyle(fontSize: 20),
                      ),

                      const SizedBox(
                        height: 10,
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      // Add the ImageSlider widget here using repairData['images']
                      CarouselSlider(
                        items: imageUrls
                            .map((imageUrl) => Container(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: Image.network(imageUrl,
                                        fit: BoxFit.cover, width: 1000.0),
                                  ),
                                ))
                            .toList(), // Example assuming 'images' is a list of image URLs
                        options: CarouselOptions(
                          height: 300,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      ProfileDetailColumn(
                          title: "Date & Time",
                          value: repairData['date&time'] != null
                              ? formatDateTime(repairData['date&time'])
                              : "N/A"),
                      ProfileDetailColumn(
                          title: "Location",
                          value: repairData['location'] ?? "N/A"),
                      ProfileDetailColumn(
                          title: "Repairs",
                          value: repairData['repair'] ?? "N/A"),
                      ProfileDetailColumn(
                          title: "Description Of Repair",
                          value: repairData['description'] ?? "N/A"),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }
}
