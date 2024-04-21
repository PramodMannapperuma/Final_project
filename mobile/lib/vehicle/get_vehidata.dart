import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/vehicle/vehicleDetails.dart';
import 'dart:io';


class VehicleDetailsForm extends StatefulWidget {
  const VehicleDetailsForm({super.key});

  @override
  State<VehicleDetailsForm> createState() => _VehicleDetailsFormState();
}

class _VehicleDetailsFormState extends State<VehicleDetailsForm> {
  int _activeStepIndex = 0;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _vehicleImages = [];

  VehicleData vehicleData = VehicleData();
  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: Text('Vehicle'),
          content: Column(
            children: [
              TextFormField(
                initialValue: vehicleData.vin,
                decoration: InputDecoration(
                    labelText: 'Vehicle Indentification Number (VIN)'),
                onChanged: (value) => setState(() => vehicleData.vin = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the VIN';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData.make,
                decoration: InputDecoration(
                  labelText: 'Make',
                ),
                onChanged: (value) => setState(() => vehicleData.make = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Make';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData.model,
                decoration: const InputDecoration(
                  labelText: 'Model',
                ),
                onChanged: (value) => setState(() => vehicleData.model = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Model';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData.model,
                decoration: const InputDecoration(
                  labelText: 'Year',
                ),
                onChanged: (value) => setState(() => vehicleData.year = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Year';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData.color,
                decoration: const InputDecoration(
                  labelText: 'Color',
                ),
                onChanged: (value) => setState(() => vehicleData.color = value),
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
                initialValue: vehicleData.licensePlateNumber,
                decoration: InputDecoration(labelText: 'License Plate Number'),
                onChanged: (value) =>
                    setState(() => vehicleData.licensePlateNumber = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the License Plate Number';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData.engineType,
                decoration: InputDecoration(
                  labelText: 'Engine Type',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData.engineType = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Engine Type';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData.fuelType,
                decoration: const InputDecoration(
                  labelText: 'Fuel Type',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData.fuelType = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Fuel Type';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData.horsePower,
                decoration: const InputDecoration(
                  labelText: 'Horse Power',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData.horsePower = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Horse Power';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData.transmission,
                decoration: InputDecoration(
                  labelText: 'Transmission',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData.transmission = value),
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
          'vehicles/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
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

  Future<void> uploadVehicleDataWithImages() async {
    showLoadingDialog(context); // Show loading dialog
    CollectionReference vehicles =
        FirebaseFirestore.instance.collection('vehicles');
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
        'vin': vehicleData.vin,
        'make': vehicleData.make,
        'model': vehicleData.model,
        'year': vehicleData.year,
        'color': vehicleData.color,
        'licensePlateNumber': vehicleData.licensePlateNumber,
        'engineType': vehicleData.engineType,
        'fuelType': vehicleData.fuelType,
        'horsePower': vehicleData.horsePower,
        'transmission': vehicleData.transmission,
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
        title: Text('Vehicle Details'),
        centerTitle: true,
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
            uploadVehicleDataWithImages();
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

class VehicleData {
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

  VehicleData({
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
