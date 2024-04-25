import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mobile/repair/repair_Info.dart';

class CheckRepairs extends StatefulWidget {
  const CheckRepairs({super.key});

  @override
  State<CheckRepairs> createState() => _CheckRepairsState();
}

class _CheckRepairsState extends State<CheckRepairs> {
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

  List<Map<String, dynamic>> repairsList = [];

  void searchRepairs(String vehicleNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('repairs')
          .where('vehicleNumber', isEqualTo: vehicleNumber)
          .get();

      setState(() {
        repairsList = querySnapshot.docs
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
        title: const Text("Repair Details"),
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
                itemCount: repairsList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> repairData = repairsList[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          String repairId = repairsList[index]['reapirId'] ?? "300";
                          print("repair id is $repairId");
                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RepairInfo( repairId: repairId,),
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
                              repairData['repair'] ?? 'No Description',
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
