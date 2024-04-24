import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/vehicle/vehicleDetails.dart';
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
            initialValue: repairData.vin,
            decoration: InputDecoration(
                labelText: 'Vehicle Indentification Number (VIN)'),
            onChanged: (value) => setState(() => repairData.vin = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the VIN';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.make,
            decoration: InputDecoration(
              labelText: 'Make',
            ),
            onChanged: (value) => setState(() => repairData.make = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Make';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.model,
            decoration: const InputDecoration(
              labelText: 'Model',
            ),
            onChanged: (value) => setState(() => repairData.model = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Model';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.model,
            decoration: const InputDecoration(
              labelText: 'Year',
            ),
            onChanged: (value) => setState(() => repairData.year = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Year';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.color,
            decoration: const InputDecoration(
              labelText: 'Color',
            ),
            onChanged: (value) => setState(() => repairData.color = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Color';
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
      title: Text('Advance'),
      content: Column(
        children: [
          TextFormField(
            initialValue: repairData.licensePlateNumber,
            decoration: InputDecoration(labelText: 'License Plate Number'),
            onChanged: (value) =>
                setState(() => repairData.licensePlateNumber = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the License Plate Number';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.engineType,
            decoration: InputDecoration(
              labelText: 'Engine Type',
            ),
            onChanged: (value) =>
                setState(() => repairData.engineType = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Engine Type';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.fuelType,
            decoration: const InputDecoration(
              labelText: 'Fuel Type',
            ),
            onChanged: (value) =>
                setState(() => repairData.fuelType = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Fuel Type';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.horsePower,
            decoration: const InputDecoration(
              labelText: 'Horse Power',
            ),
            onChanged: (value) =>
                setState(() => repairData.horsePower = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Horse Power';
              }
              return null; // indicates the input is correct
            },
          ),
          TextFormField(
            initialValue: repairData.transmission,
            decoration: InputDecoration(
              labelText: 'Transmission',
            ),
            onChanged: (value) =>
                setState(() => repairData.transmission = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Transmission';
              }
              return null; // indicates the input is correct
            },
          ),
        ],
      ),
    ),
    Step(
      state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 2,
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
      width: 400,
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
    CollectionReference vehicles =
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
      await vehicles.add({
        'userEmail' : userEmail,
        'vin': repairData.vin,
        'make': repairData.make,
        'model': repairData.model,
        'year': repairData.year,
        'color': repairData.color,
        'licensePlateNumber': repairData.licensePlateNumber,
        'engineType': repairData.engineType,
        'fuelType': repairData.fuelType,
        'horsePower': repairData.horsePower,
        'transmission': repairData.transmission,
        'imageUrls': imageUrls, // Store image URLs in Firestore
      });
      Navigator.of(context).pop(); // Dismiss the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vehicle details saved successfully!'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VehicleDetails(),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop(); // Dismiss the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update vehicle details : $e'),
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
          uploadImagesAndGetUrls();
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
  String vin;
  String make;
  String model;
  String year;
  String color;
  String licensePlateNumber;
  String engineType;
  String fuelType;
  String horsePower;
  String transmission;

  // Add more fields as necessary

  RepairData({
    this.vin = '',
    this.make = '',
    this.model = '',
    this.year = '',
    this.color = '',
    this.licensePlateNumber = '',
    this.engineType = '',
    this.fuelType = '',
    this.horsePower = '',
    this.transmission = '',
  });
}
