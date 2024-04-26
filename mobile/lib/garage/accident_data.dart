import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/profile_view.dart';

class AccidentData extends StatefulWidget {
  final String accidentId;
  const AccidentData({super.key, required this.accidentId});

  @override
  State<AccidentData> createState() => _AccidentDataState();
}

class _AccidentDataState extends State<AccidentData> {
  late Future<Map<String, dynamic>?> accidentDetailsFuture;

  String formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  Future<Map<String, dynamic>?> fetchAccidentDetails() async {
    DocumentSnapshot repairDoc = await FirebaseFirestore.instance
        .collection('accidents')
        .doc(widget.accidentId)
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
        title: Text("Accident Details"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: fetchAccidentDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData && snapshot.data != null) {
              final accidentData = snapshot.data!;
              print("Accident data print $accidentData");


              List<String> imageUrls =
                  (accidentData['imageUrls'] as List<dynamic>?)
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
                        accidentData['repair'] ?? 'No Title',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 10),
                      Text(
                        accidentData['description'] ?? 'No Description',
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
                          value: accidentData['date&time'] != null
                              ? formatDateTime(accidentData['date&time'])
                              : "N/A"),
                      ProfileDetailColumn(
                          title: "Location",
                          value: accidentData['location'] ?? "N/A"),
                      ProfileDetailColumn(
                          title: "Repairs",
                          value: accidentData['repair'] ?? "N/A"),
                      ProfileDetailColumn(
                          title: "Description Of Repair",
                          value: accidentData['description'] ?? "N/A"),
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
