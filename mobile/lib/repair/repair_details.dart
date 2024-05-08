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
  // Fetch the vehicle number(s) associated with the logged-in user's email
  Future<List<String>> fetchVehicleNumbersByEmail() async {
    try {
      // Retrieve the currently logged-in user's email
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("No user is currently logged in.");
        return [];
      }

      String userEmail = user.email!;
      print("Logged-in user email: $userEmail");

      // Query the vehicles collection using the user's email
      QuerySnapshot vehicleSnapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('userEmail', isEqualTo: userEmail)
          .get();

      if (vehicleSnapshot.docs.isEmpty) {
        print("No vehicles found for the given email.");
        return [];
      }

      // Extract vehicle numbers from the query results
      return vehicleSnapshot.docs
          .map((doc) => doc['licensePlateNumber'] as String)
          .toList();
    } catch (e) {
      print("Error fetching vehicle numbers: $e");
      return [];
    }
  }

  // Fetch the repair details using vehicle numbers
  Future<List<Map<String, dynamic>>> fetchRepairDetails() async {
    try {
      // Fetch all vehicle numbers associated with the logged-in user
      List<String> vehicleNumbers = await fetchVehicleNumbersByEmail();
      if (vehicleNumbers.isEmpty) {
        return [];
      }

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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchRepairDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading repair details"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No repair details found"));
          }

          List<Map<String, dynamic>> repairs = snapshot.data!;

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Hello,", style: TextStyle(fontSize: 40)),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Pramod Mannapperuma", style: TextStyle(fontSize: 30)),
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
                  // Dynamically generate repair widgets based on fetched data
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
      ),
    );
  }
}
