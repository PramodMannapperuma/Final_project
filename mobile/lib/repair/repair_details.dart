import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'repair_Info.dart';

class RepairDetails extends StatefulWidget {
  const RepairDetails({super.key});

  @override
  State<RepairDetails> createState() => _RepairDetailsState();
}

class _RepairDetailsState extends State<RepairDetails> {
  // Fetch the current user's data
  Future<Map<String, dynamic>?> fetchCurrentUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Fetch user details from Firestore
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users') // Change to your collection name
            .where('userId', isEqualTo: user.uid) // Adjust to match your field name
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Assuming there's only one document matching the condition
          return querySnapshot.docs.first.data() as Map<String, dynamic>?;
        } else {
          return null; // Document not found
        }
      } catch (e) {
        // Handle any errors that occurred during fetching
        print("Error fetching user data: $e");
        return null;
      }
    }
    return null; // No user logged in
  }

  // Fetch the vehicle numbers and their associated repairs
  Future<List<Map<String, dynamic>>> fetchRepairDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("No user is currently logged in.");
        return [];
      }

      String userEmail = user.email!;
      QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('userEmail', isEqualTo: userEmail)
          .get();

      if (vehicleSnapshot.docs.isEmpty) {
        print("No vehicles found for the given email.");
        return [];
      }

      // Extract the vehicle numbers associated with this email
      List<String> vehicleNumbers = vehicleSnapshot.docs
          .map((doc) => doc['licensePlateNumber'] as String)
          .toList();

      // Query the repairs collection using the vehicle numbers
      QuerySnapshot repairSnapshot = await FirebaseFirestore.instance
          .collection('repairs')
          .where('vehicleNumber', whereIn: vehicleNumbers)
          .get();

      if (repairSnapshot.docs.isEmpty) {
        return [];
      }

      // Extract repair data and return it
      return repairSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching repair details: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repair Details"),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchCurrentUserDetails(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (userSnapshot.hasError) {
            return Center(child: Text("Error: ${userSnapshot.error}"));
          } else if (userSnapshot.hasData && userSnapshot.data != null) {
            // Extract the user's name from the fetched data
            String firstName = userSnapshot.data!['firstName'] ?? 'Unknown';
            String lastName = userSnapshot.data!['lastName'] ?? 'User';
            String fullName = "$firstName $lastName";

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchRepairDetails(),
              builder: (context, repairSnapshot) {
                if (repairSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (repairSnapshot.hasError) {
                  return const Center(child: Text("Error loading repair details"));
                } else if (!repairSnapshot.hasData || repairSnapshot.data!.isEmpty) {
                  return const Center(child: Text("No repair details found"));
                }

                List<Map<String, dynamic>> repairs = repairSnapshot.data!;

                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              fullName,
                              style: const TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Your past vehicle repairs,",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: const Divider(thickness: 1.0),
                        ),
                        for (var repair in repairs)
                          GestureDetector(
                            onTap: () {
                              String repairId = repair['reapirId'] ?? 'defaultRepairId';
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RepairInfo(repairId: repairId),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.settings_outlined),
                                    const SizedBox(width: 40),
                                    Text(
                                      repair['repair'] ?? 'Unknown Repair',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(width: 40),
                                    const Icon(Icons.arrow_forward_ios_rounded),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width / 1.1,
                                  child: const Divider(thickness: 1.0),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No user data available"));
          }
        },
      ),
    );
  }
}
