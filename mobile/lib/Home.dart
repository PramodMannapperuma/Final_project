import 'package:flutter/material.dart';
import 'package:mobile/screens/profile.dart';
import 'package:mobile/screens/revenue_liscense.dart';
import 'package:mobile/vehicle/vehicleScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>?> fetchUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    return userDoc.data() as Map<String, dynamic>?;
  }
  return null;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  late PageController pageController;
  final Color navigationBarColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: const Icon(Icons.chevron_left),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          // width: 20.0,
                          ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, ",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      FutureBuilder<Map<String, dynamic>?>(
                        future: fetchUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData && snapshot.data != null) {
                              String firstName = snapshot.data!['firstName'] ?? 'User';
                              String lastName = snapshot.data!['lastName'] ?? '';
                              return Text(
                                "$firstName $lastName",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              );
                            } else {
                              return Text(
                                "User",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              );
                            }
                          } else {
                            // While waiting for the data to load, you can display a loading spinner or similar widget
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Image.asset(
                  'assets/Images/shit.jpg',
                  width: 400, // Set the width of the image
                  height: 200, // Set the height of the image
                ),
              ),
              Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfFilePicker(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.receipt), // Add your desired icon here
                        SizedBox(
                          width: 10,
                        ), // Add some spacing between the icon and text
                        Text(
                          "Revenue License",
                          style: TextStyle(fontSize: 20),
                        ),
                        // Image.asset(
                        //   "assets/Images/home.jpg",
                        //   height: 50,
                        //   width: 50,
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehicleScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                            Icons.directions_car), // Add your desired icon here
                        const SizedBox(
                          width: 10,
                        ), // Add some spacing between the icon and text
                        const Text(
                          "Vehicle",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.person), // Add your desired icon here
                        const SizedBox(
                          width: 10,
                        ), // Add some spacing between the icon and text
                        const Text(
                          "User Profile",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ClickableCard(
                    title: 'Card 3',
                    onTap: () {
                      // Handle card tap
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClickableCard extends StatelessWidget {
  final String title;
  final Function onTap;

  const ClickableCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        // color: Colors.blue,
        child: SizedBox(
          height: 110,
          width: 170,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
