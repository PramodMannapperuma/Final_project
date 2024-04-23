import 'package:flutter/material.dart';
import 'package:mobile/screens/profile.dart';
import 'package:mobile/screens/revenue_liscense.dart';
import 'package:mobile/vehicle/vehicleScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> fetchUserRole() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("No user logged in.");
    return 'none';
  }

  // Attempt to find the user in the 'users' collection using a field query
  QuerySnapshot userQuery = await FirebaseFirestore.instance
      .collection('users')
      .where('userId', isEqualTo: user.uid)
      .get();

  if (userQuery.docs.isNotEmpty) {
    print("Found user in 'users' collection.");
    return 'user';  // Role is 'user'
  }

  // If not found in 'users', check in the 'garages' collection
  QuerySnapshot garageQuery = await FirebaseFirestore.instance
      .collection('garages')
      .where('userId', isEqualTo: user.uid)
      .get();

  if (garageQuery.docs.isNotEmpty) {
    print("Found user in 'garages' collection.");
    return 'garage';  // Role is 'garage'
  }

  // If not found in 'garages', check in the 'insurance' collection
  QuerySnapshot insuranceQuery = await FirebaseFirestore.instance
      .collection('insurenceCo')
      .where('userId', isEqualTo: user.uid)
      .get();
  print("user Id ${user.uid}");

  if (insuranceQuery.docs.isNotEmpty) {
    print("Found user in 'insurenceCo' collection.");
    return 'insurance';  // Role is 'insurance'
  }

  // If the user is not found in any collection
  print("User role not found in any collection.");
  print("user Id ${user.uid}");
  return 'none';  // Default role if none of the above
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<String> userRoleFuture = fetchUserRole();
  int selectedIndex = 0;
  late PageController pageController;
  final Color navigationBarColor = Colors.white;

  @override
  void initState() {
    super.initState();
    userRoleFuture =
        fetchUserRole(); // Provide a default role in case of an error
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: userRoleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return buildHomePage(snapshot.data ?? 'none');
          }
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ); // Show a loading spinner while waiting
      },
    );
  }

  Widget buildHomePage(String role) {
    switch (role) {
      case 'user':
        return UserHomePage(); // Widget for users
      case 'garage':
        return GarageHomePage(); // Widget for garage owners
      case 'insurance':
        return InsuranceHomePage(); // Widget for insurance agents
      default:
        return buildDefaultHomePage();
    }
  }

  Widget UserHomePage() {
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
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  String firstName =
                                      snapshot.data!['firstName'] ?? 'User';
                                  String lastName =
                                      snapshot.data!['lastName'] ?? '';
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildDefaultHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Default Home Page"),
      ),
      body: Center(
        child: Text("No specific role found, displaying default home page."),
      ),
    );
  }
  Widget GarageHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Garage Home Page"),
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
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  String firstName =
                                      snapshot.data!['firstName'] ?? 'User';
                                  String lastName =
                                      snapshot.data!['lastName'] ?? '';
                                  return Text(
                                    "$firstName ",
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
                  'assets/Images/garage1.webp',
                  width: 500, // Set the width of the image
                  height: 220, // Set the height of the image
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
                          "Check Accidents",
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
                    child: const Row(
                      children: [
                        Icon(
                            Icons.directions_car), // Add your desired icon here
                        SizedBox(
                          width: 10,
                        ), // Add some spacing between the icon and text
                        Text(
                          "Check Repairs",
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
                    child: const Row(
                      children: [
                        Icon(Icons.person), // Add your desired icon here
                        SizedBox(
                          width: 10,
                        ), // Add some spacing between the icon and text
                        Text(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget InsuranceHomePage() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Insurance Co Home Page"),
      ),
      body:  SingleChildScrollView(
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
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  String firstName =
                                      snapshot.data!['firstName'] ?? 'User';
                                  String lastName =
                                      snapshot.data!['lastName'] ?? '';
                                  return Text(
                                    "$firstName ",
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
