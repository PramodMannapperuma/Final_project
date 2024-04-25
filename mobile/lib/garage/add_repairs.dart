import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRepair extends StatefulWidget {
  const AddRepair({super.key});

  @override
  State<AddRepair> createState() => _AddRepairState();
}

class _AddRepairState extends State<AddRepair> {

  int _activeStepIndex = 0;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _vehicleImages = [];

  RepairData repairData = RepairData();

  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: Text('Vehicle Data'),
      content: Column(
        children: [
          TextFormField(
            initialValue: repairData.vehicleNumber,
            decoration: InputDecoration(
                labelText: 'Vehicle Number'),
            onChanged: (value) => setState(() => repairData.vehicleNumber = value ?? "na"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Number';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.repair,
            decoration: InputDecoration(
              labelText: 'Repair',
            ),
            onChanged: (value) => setState(() => repairData.repair = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Repair';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.location,
            decoration: const InputDecoration(
              labelText: 'Location',
            ),
            onChanged: (value) => setState(() => repairData.location = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Location';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.location,
            decoration: const InputDecoration(
              labelText: 'Describe the repair',
            ),
            onChanged: (value) => setState(() => repairData.description = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please describe the repair';
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
              child: Text('Add Repair Images'),
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
          'repairs/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
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
    FirebaseFirestore.instance.collection('repairs');
    List<String> imageUrls =
    await uploadImagesAndGetUrls(); // Get image URLs from storage

    User? user = FirebaseAuth.instance.currentUser; // Get the current logged-in user
    String? userEmail = user?.email; // Get the user's email

    if (userEmail == null) {
      Navigator.of(context).pop(); // Dismiss the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No logged-in user found')),
      );
      return;
    }

    try {
      String repairId = DateTime.now().millisecondsSinceEpoch.toString();
      await repairs.doc(repairId).set({
        'reapirId' : repairId,
        'garageEmail' : userEmail,
        'vehicleNumber': repairData.vehicleNumber,
        'repair': repairData.repair,
        'location': repairData.location,
        'description': repairData.description,
        'date&time': DateTime.now(),
        'imageUrls': imageUrls, // Store image URLs in Firestore
      });
      Navigator.of(context).pop(); // Dismiss the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Repair details saved successfully!'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AddRepair(),
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
        title: const Text("Add Repairs"),
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

void showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible:
    false, // Prevents the dialog from closing until we manually do it
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 24),
            Text("Uploading data..."),
          ],
        ),
      );
    },
  );
}
class RepairData {
  String vehicleNumber;
  String repair;
  String location;
  String description;


  // Add more fields as necessary

  RepairData({
    this.vehicleNumber = '',
    this.repair = '',
    this.location = '',
    this.description = '',
  });
}
