import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Accident_Info.dart';

class AccidentDetails extends StatefulWidget {
  const AccidentDetails({super.key});

  @override
  State<AccidentDetails> createState() => _AccidentDetailsState();
}

class _AccidentDetailsState extends State<AccidentDetails> {
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

  // Fetch accident details for the logged-in user (already implemented)
  Future<List<Map<String, dynamic>>> fetchAccidentDetails() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('Error: No user is currently logged in.');
        return [];
      }

      String userEmail = currentUser.email!;
      print('Logged-in user email: $userEmail');

      QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('userEmail', isEqualTo: userEmail)
          .get();

      if (vehicleSnapshot.docs.isEmpty) {
        print('Error: No vehicles found for the given email.');
        return [];
      }

      String vehicleNumber = vehicleSnapshot.docs.first['licensePlateNumber'];
      print('Vehicle number: $vehicleNumber');

      QuerySnapshot accidentSnapshot = await FirebaseFirestore.instance
          .collection('accidents')
          .where('vehicleNumber', isEqualTo: vehicleNumber)
          .get();

      if (accidentSnapshot.docs.isEmpty) {
        print('Error: No accident details found for the given vehicle number.');
        return [];
      }

      return accidentSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching accident details: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accident Details"),
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

            // Fetch accident details
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchAccidentDetails(),
              builder: (context, accidentSnapshot) {
                if (accidentSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (accidentSnapshot.hasError) {
                  return const Center(child: Text("Error loading accident details"));
                } else if (!accidentSnapshot.hasData || accidentSnapshot.data!.isEmpty) {
                  return const Center(child: Text("No accident details found"));
                }

                List<Map<String, dynamic>> accidents = accidentSnapshot.data!;

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
                              "Your past vehicle Accidents,",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: const Divider(thickness: 1.0),
                        ),
                        // Dynamically generate accident widgets based on fetched data
                        for (var accident in accidents)
                          GestureDetector(
                            onTap: () {
                              String accidentId = accident['accidentId'] ?? '30000';
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AccidentInfo(accidentId: accidentId),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.minor_crash_sharp),
                                    const SizedBox(width: 40),
                                    Text(
                                      accident['accident'] ?? 'Unknown Accident',
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
