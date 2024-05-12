import 'package:flutter/material.dart';
import 'package:mobile/feedback.dart';
import 'package:mobile/info.dart';
import 'package:mobile/repair/repair_details.dart';
import 'package:mobile/vehicle/vehicleDetails.dart';
import '../screens/profile.dart';
import 'EditVehicleDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  String? _displayedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchImageFromFirebase();
  }

  Future<void> fetchImageFromFirebase() async {
    User? user = _auth.currentUser;
    if (user?.email != null) {
      var snapshot = await _firestore.collection('vehicles')
          .where('userEmail', isEqualTo: user!.email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var vehicleData = snapshot.docs.first.data();
        var imageUrl = vehicleData['imageUrls'];
        updateDisplayedImage(imageUrl);
      }
    }
  }

  void updateDisplayedImage(dynamic imageUrl) {
    if (imageUrl is List && imageUrl.isNotEmpty) {
      _setDisplayedImage(imageUrl.first);
    } else if (imageUrl is String) {
      _setDisplayedImage(imageUrl);
    }
  }

  void _setDisplayedImage(String imageUrl) {
    setState(() {
      _displayedImage = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle'),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          _buildImageWidget(),
          const SizedBox(height: 10),
          const Text("", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          ..._buildProfileMenuWidgets(),
          const Divider(thickness: 1),
          ProfileMenuWidget(
            title: "Feedback",
            icon: Icons.info,
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  FeedbackScreen()),
            ),
          ),
          ProfileMenuWidget(
            title: "Info",
            icon: Icons.info,
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  FAQAndPricingScreen()),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    return _displayedImage != null
        ? CircleAvatar(
      backgroundImage: NetworkImage(_displayedImage!),
      radius: 60,
    )
        : const CircularProgressIndicator();
  }

  List<Widget> _buildProfileMenuWidgets() {
    return [
      ProfileMenuWidget(
        title: "Details",
        icon: Icons.car_crash,
        onPress: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VehicleDetails()),
        ),
      ),
      ProfileMenuWidget(
        title: "Edit Vehicle",
        icon: Icons.settings,
        onPress: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditVehicleDetails()),
        ),
      ),
      ProfileMenuWidget(
        title: "Repair Details",
        icon: Icons.tire_repair_sharp,
        onPress: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RepairDetails()),
        ),
      ),
    ];
  }
}

