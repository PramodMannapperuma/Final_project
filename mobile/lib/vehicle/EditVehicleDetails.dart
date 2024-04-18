import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:mobile/vehicle/vehicleDetails.dart';

class EditVehicleDetails extends StatefulWidget {
  const EditVehicleDetails({super.key});

  @override
  State<EditVehicleDetails> createState() => _EditVehicleDetailsState();
}

class _EditVehicleDetailsState extends State<EditVehicleDetails> {
  int _activeStepIndex = 0;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _vehicleImages = [];
  Map<String, dynamic> vehicleData = {};
  String? documentId; // To store the document ID of the vehicle data
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVehicleData();
  }

  Future<void> fetchVehicleData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user?.email != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('userEmail', isEqualTo: user!.email)
          .limit(1)
          .get();
      print('snapshot : $snapshot');

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          vehicleData = snapshot.docs.first.data();
          documentId = snapshot.docs.first.id;
          _isLoading = false; // Set loading to false when data is fetched
        });
        print('vehicledata : $vehicleData');
      } else {
        setState(() {
          _isLoading = false; // Set loading to false if no data found
        });
      }
    }
  }

  Future<void> uploadVehicleDataWithImages() async {
    if (documentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No vehicle data found to update.')),
      );
      return;
    }

    List<String> imageUrls = await uploadImagesAndGetUrls();
    vehicleData['imageUrls'] = imageUrls;

    FirebaseFirestore.instance
        .collection('vehicles')
        .doc(documentId)
        .update(vehicleData)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vehicle details updated successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VehicleDetails()),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update vehicle details: $error')),
      );
    });
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
          title: Text('Vehicle'),
          content: Column(
            children: [
              Text('vehicle data in stepper ${vehicleData['vin']}'),
              TextFormField(
                initialValue: vehicleData['vin'] ?? 'N/A',
                decoration: InputDecoration(
                  labelText: 'Vehicle Indentification Number (VIN)',
                ),
                onChanged: (value) {
                  setState(() {
                    vehicleData['vin'] = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the VIN';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData['make'],
                decoration: InputDecoration(
                  labelText: 'Make',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData['make'] = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Make';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData['model'],
                decoration: InputDecoration(
                  labelText: 'Model',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData['model'] = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Model';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData['year'],
                decoration: InputDecoration(
                  labelText: 'Year',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData['year'] = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Year';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData['color'],
                decoration: InputDecoration(
                  labelText: 'Color',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData['color'] = value),
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
          state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: Text('Advance'),
          content: Column(
            children: [
              TextFormField(
                initialValue: vehicleData['licensePlateNumber'],
                decoration: InputDecoration(labelText: 'License Plate Number'),
                onChanged: (value) =>
                    setState(() => vehicleData['licensePlateNumber'] = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the License Plate Number';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData['engineType'],
                decoration: InputDecoration(
                  labelText: 'Engine Type',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData['engineType'] = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Engine Type';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData['fuelType'],
                decoration: InputDecoration(
                  labelText: 'Fuel Type',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData['fuelType'] = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Fuel Type';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData['horsePower'],
                decoration: InputDecoration(
                  labelText: 'Horse Power',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData['horsePower'] = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Horse Power';
                  }
                  return null; // indicates the input is correct
                },
              ),
              TextFormField(
                initialValue: vehicleData['transmission'],
                decoration: InputDecoration(
                  labelText: 'Transmission',
                ),
                onChanged: (value) =>
                    setState(() => vehicleData['transmission'] = value),
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

  @override
  Widget build(BuildContext context) {
    print('Vehicle Data in UI: $vehicleData');
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Details'),
        centerTitle: true,
      ),
      body: _isLoading // Show loading screen if data is still loading
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