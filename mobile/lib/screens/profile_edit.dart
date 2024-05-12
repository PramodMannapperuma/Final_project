import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  int _activeStepIndex = 0;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _profileImages = [];
  Map<String, dynamic> userData = {};
  String? documentId; // To store the document ID of the user data
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user?.email != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user!.email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          userData = snapshot.docs.first.data();
          documentId = snapshot.docs.first.id;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> uploadUserDataWithImages() async {
    if (documentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user data found to update.')),
      );
      return;
    }

    List<String> imageUrls = await uploadImagesAndGetUrls();
    userData['imageUrls'] = imageUrls;

    FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update(userData)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $error')),
      );
    });
  }

  Future<List<String>> uploadImagesAndGetUrls() async {
    List<String> imageUrls = [];
    for (var image in _profileImages) {
      String fileName = 'users/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
      File file = File(image.path);
      try {
        TaskSnapshot snapshot = await FirebaseStorage.instance.ref(fileName).putFile(file);
        String imageUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
    return imageUrls;
  }

  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: Text('Photos'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageListView(),
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Add Vehicle Images'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    ),
    Step(
      state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 1,
      title: Text('User Data'),
      content: Column(
        children: [
          TextFormField(
            initialValue: userData['firstName'] ?? 'N/A',
            decoration: InputDecoration(
              labelText: 'First Name',
            ),
            onChanged: (value) {
              setState(() {
                userData['firstName'] = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter first name';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: userData['lastName'],
            decoration: InputDecoration(
              labelText: 'Last Name',
            ),
            onChanged: (value) =>
                setState(() => userData['lastName'] = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Make';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: userData['email'],
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            onChanged: (value) =>
                setState(() => userData['email'] = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Email';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: userData['gender'],
            decoration: InputDecoration(
              labelText: 'Gender',
            ),
            onChanged: (value) =>
                setState(() => userData['gender'] = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the gender';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: userData['password'],
            decoration: InputDecoration(
              labelText: 'Change Password',
            ),
            onChanged: (value) =>
                setState(() => userData['password'] = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the password';
              }
              return null; // indicates the input is correct
            },
          ),
        ],
      ),
    ),

  ];

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _profileImages.addAll(selectedImages);
      });
    }
  }

  Widget _buildImageListView() {
    return SizedBox(
      height: 300, // Set the height of the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _profileImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(File(_profileImages[index].path)),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stepper(
        currentStep: _activeStepIndex,
        type: StepperType.horizontal,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() => _activeStepIndex += 1);
          } else {
            // Last step
            uploadImagesAndGetUrls();
            uploadUserDataWithImages();
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          _activeStepIndex -= 1;
          setState(() {});
        },
      ),
    );
  }
}
