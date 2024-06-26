import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mobile/accident/Accident_Info.dart';
import 'package:mobile/garage/accident_data.dart';

class CheckAccidents extends StatefulWidget {
  const CheckAccidents({super.key});

  @override
  State<CheckAccidents> createState() => _CheckAccidentsState();
}

class _CheckAccidentsState extends State<CheckAccidents> {
  TextEditingController searchController = TextEditingController();

  Future<Map<String, dynamic>?> fetchCurrentUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Check if user ID matches the document ID
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('garages')
            .where('userId', isEqualTo: user.uid)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Assuming there's only one document matching the condition
          return querySnapshot.docs.first.data() as Map<String, dynamic>?;
        } else {
          // Document not found
          return null;
        }
      } catch (e) {
        // Error fetching document
        print("Error fetching user data: $e");
        return null;
      }
    }
    return null;
  }

  List<Map<String, dynamic>> accidentList = [];

  void searchRepairs(String vehicleNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('accidents')
          .where('vehicleNumber', isEqualTo: vehicleNumber)
          .get();

      setState(() {
        accidentList = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error searching repairs: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Check Accidents"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Map<String, dynamic>?>(
                  future: fetchCurrentUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData && snapshot.data != null) {
                      // Use null safety check to avoid potential null errors
                      String firstName = snapshot.data!['name'] ?? 'First Name';
                      return Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Hello,",
                                style: TextStyle(fontSize: 40),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "$firstName ",
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Text(
                          "No user data available"); // Handle case where no data is available
                    }
                  }),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.1,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Enter Vehicle Number",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        String vehicleNumber = searchController.text.trim();
                        searchRepairs(vehicleNumber);
                      },
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: accidentList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> accidentData = accidentList[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          String accidentId = accidentList[index]['accidentId'] ?? "300";
                          print("accident id is $accidentId");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccidentData(accidentId: accidentId),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(FluentIcons
                                .settings_chat_20_filled), // Add your desired icon here
                            SizedBox(
                                width:
                                40), // Add some spacing between the icon and text
                            Text(
                              accidentData['accident'] ?? 'No Description',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 40),
                            Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: const Divider(
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

