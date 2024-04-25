import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../garage/add_repairs.dart';

class AddAccidents extends StatefulWidget {
  const AddAccidents({super.key});

  @override
  State<AddAccidents> createState() => _AddAccidentsState();
}

class _AddAccidentsState extends State<AddAccidents> {
  int _activeStepIndex = 0;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _vehicleImages = [];

  AccidentData accidentData = AccidentData();

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: Text('Vehicle Data'),
          content: Column(
            children: [
              TextFormField(
                initialValue: accidentData.vehicleNumber,
                decoration: InputDecoration(labelText: 'Vehicle Number'),
                onChanged: (value) =>
                    setState(() => accidentData.vehicleNumber = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Number';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: accidentData.accident,
                decoration: InputDecoration(
                  labelText: 'Accident',
                ),
                onChanged: (value) =>
                    setState(() => accidentData.accident = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Accident';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: accidentData.location,
                decoration: const InputDecoration(
                  labelText: 'Location',
                ),
                onChanged: (value) =>
                    setState(() => accidentData.location = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Location';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: accidentData.location,
                decoration: const InputDecoration(
                  labelText: 'Describe the accident',
                ),
                onChanged: (value) =>
                    setState(() => accidentData.description = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe the Repair';
                  }
                  return null; // indicates the input is correct
                },
              ),
            ],
          ),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: Text('Add Photos'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildImageListView(),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text('Add Accident Images'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ];

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _vehicleImages.addAll(selectedImages);
      });
    }
  }

  Widget _buildImageListView() {
    return SizedBox(
      height: 300, // Set the height of the horizontal list
      width: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _vehicleImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(File(_vehicleImages[index].path)),
          );
        },
      ),
    );
  }

  Future<List<String>> uploadImagesAndGetUrls() async {
    List<String> imageUrls = [];
    for (var image in _vehicleImages) {
      String fileName =
          'accidents/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
      File file = File(image.path);

      try {
        TaskSnapshot snapshot =
            await FirebaseStorage.instance.ref(fileName).putFile(file);
        String imageUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
        print("Image uploaded: $imageUrl");
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
    return imageUrls;
  }

  Future<void> uploadRepairDataWithImages() async {
    showLoadingDialog(context); // Show loading dialog
    CollectionReference repairs =
        FirebaseFirestore.instance.collection('accidents');
    List<String> imageUrls =
        await uploadImagesAndGetUrls(); // Get image URLs from storage

    User? user =
        FirebaseAuth.instance.currentUser; // Get the current logged-in user
    String? userEmail = user?.email; // Get the user's email

    if (userEmail == null) {
      Navigator.of(context).pop(); // Dismiss the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No logged-in user found')),
      );
      return;
    }

    try {
      String accidentId = DateTime.now().millisecondsSinceEpoch.toString();
      await repairs.doc(accidentId).set({
        'accidentId': accidentId,
        'insurenceEmail': userEmail,
        'vehicleNumber': accidentData.vehicleNumber,
        'accident': accidentData.accident,
        'location': accidentData.location,
        'description': accidentData.description,
        'date&time': DateTime.now(),
        'imageUrls': imageUrls,
      });
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Repair details saved successfully!'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AddAccidents(),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop(); // Dismiss the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update repair details : $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accidents"),
      ),
      body: Stepper(
        currentStep: _activeStepIndex,
        type: StepperType.horizontal,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() => _activeStepIndex += 1);
          } else {
            // Last step
            // uploadImagesAndGetUrls();
            uploadRepairDataWithImages();
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

class AccidentData {
  String vehicleNumber;
  String accident;
  String location;
  String description;

  // Add more fields as necessary

  AccidentData({
    this.vehicleNumber = '',
    this.accident = '',
    this.location = '',
    this.description = '',
  });
}
