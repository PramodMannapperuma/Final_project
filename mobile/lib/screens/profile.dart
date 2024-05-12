import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/feedback.dart';
import 'package:mobile/info.dart';
import 'package:mobile/screens/profile_edit.dart';
import 'package:mobile/screens/profile_view.dart';
import 'package:mobile/screens/show_revenue.dart';

import '../auth/login.dart';

Future<Map<String, dynamic>?> fetchUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return userDoc.data() as Map<String, dynamic>?;
  }
  return null;
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: _imageFile != null
                      ? FileImage(File(_imageFile!.path))
                      : const AssetImage("assets/Images/user.png")
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 2,
                  right: 4,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blueGrey.withOpacity(0.8),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((build) => bottomSheet()),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder<Map<String, dynamic>?>(
                future: fetchUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();  // Show loading indicator while waiting
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");  // Show error message
                  } else if (snapshot.hasData) {
                    // Assuming your user data includes 'firstName', 'lastName', and 'email' fields
                    String firstName = snapshot.data!['firstName'] ?? 'First Name';
                    String lastName = snapshot.data!['lastName'] ?? 'Last Name';
                    String email = snapshot.data!['email'] ?? 'No email found';
                    return Column(
                      children: [
                        Text(
                          "$firstName $lastName", // Displaying the user's full name
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          email, // Displaying the email
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    );
                  } else {
                    return Text("No user data available");  // Handle case where no data is available
                  }
                }
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
            ),
            ProfileMenuWidget(
              title: "Details",
              icon: Icons.account_circle_outlined,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileDetails()),
                );
              },
            ),
            ProfileMenuWidget(
              title: "Edit Profile",
              icon: Icons.settings,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfilePage()),
                );
              },
            ),
            ProfileMenuWidget(
              title: "FeedBack",
              icon: Icons.library_books_sharp,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeedbackScreen()),
                );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ProfileMenuWidget(
              title: "Info",
              icon: Icons.info,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FAQAndPricingScreen()),
                );
              },
            ),
            ProfileMenuWidget(
              title: "Log Out",
              icon: Icons.logout,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginForm()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18.0),
          topLeft: Radius.circular(18.0),
          bottomRight: Radius.circular(18.0),
          bottomLeft: Radius.circular(18.0),
        ),
      ),
      padding: const EdgeInsets.only(top: 9),
      height: 180,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 9, left: 4, top: 0, right: 4),
      child: Column(
        children: [
          const Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: const Icon(Icons.camera, color: Colors.black87),
                label: const Text(
                  "Camera",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black87),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.black87,
                ),
                label: const Text(
                  "Gallery",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black87),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                label: const Text(
                  "Cancel",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
      Navigator.pop(context); // Close the bottom sheet after selecting an image
    }
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueGrey.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: Colors.black87,
        ),
      ),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: textColor, fontSize: 17.0)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.blueGrey,
              ),
            )
          : null,
    );
  }
}
