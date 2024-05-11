import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/profile_view.dart';

class AccidentInfo extends StatefulWidget {
  final String accidentId;
  const AccidentInfo({super.key, required this.accidentId});

  @override
  State<AccidentInfo> createState() => _AccidentInfoState();
}

class _AccidentInfoState extends State<AccidentInfo> {
  late Future<Map<String, dynamic>?> accidentDetailsFuture;

  // Method to format a Firestore Timestamp to a readable string
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  // Method to retrieve accident details from Firestore based on accident ID
  Future<Map<String, dynamic>?> getAccidentData() async {
    DocumentSnapshot accidentDoc = await FirebaseFirestore.instance
        .collection('accidents')
        .doc(widget.accidentId)
        .get();
    if (accidentDoc.exists) {
      return accidentDoc.data() as Map<String, dynamic>?;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accident Details"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: getAccidentData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData && snapshot.data != null) {
              final accidentData = snapshot.data!;

              // Ensure that the image URLs are lists and convert them to string lists
              List<String> imageUrls =
                  (accidentData['imageUrls'] as List<dynamic>?)
                      ?.map((imageUrl) => imageUrl.toString())
                      .toList() ??
                      [];

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display accident details using the fetched data
                      Text(
                        accidentData['accident'] ?? 'No Title',
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        accidentData['description'] ?? 'No Description',
                        style: const TextStyle(fontSize: 20),
                      ),

                      const SizedBox(
                        height: 10,
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      // Add the ImageSlider widget here using accidentData['imageUrls']
                      CarouselSlider(
                        items: imageUrls
                            .map((imageUrl) => Container(
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
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
                          const Duration(milliseconds: 800),
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
                              ? formatTimestamp(accidentData['date&time'])
                              : "N/A"),
                      ProfileDetailColumn(
                          title: "Location",
                          value: accidentData['location'] ?? "N/A"),

                      ProfileDetailColumn(
                        title: 'Documented by',
                        value: accidentData['insurenceEmail'] ?? "N/A",
                      ),
                      ProfileDetailColumn(
                          title: "Description Of Accident",
                          value: accidentData['description'] ?? "N/A"),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }
}