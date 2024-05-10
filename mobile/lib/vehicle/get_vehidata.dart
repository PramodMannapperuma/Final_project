import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:mobile/vehicle/vehicleDetails.dart';
import 'dart:io';

// Encryption utility class
// class EncryptionService {
//   // A 32-byte long key for AES-256
//   static final _key = encrypt.Key.fromUtf8('A32ByteLongEncryptionKey123456!');
//   static final _iv = encrypt.IV.fromLength(16);
//   static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));
//
//   EncryptionService() {
//     // Print the length of the key in bytes
//     print('Key length in bytes: ${_key.bytes.length}');
//   }
//
//   static String encryptText(String text) {
//     final encrypted = _encrypter.encrypt(text, iv: _iv);
//     return encrypted.base64;
//   }
//
//   static String decryptText(String encryptedText) {
//     final decrypted = _encrypter.decrypt64(encryptedText, iv: _iv);
//     return decrypted;
//   }
// }

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
      title: const Text('Vehicle'),
      content: Column(
        children: [
          TextFormField(
            initialValue: vehicleData.vin,
            decoration: const InputDecoration(
                labelText: 'Vehicle Identification Number (VIN)'),
            onChanged: (value) => setState(() => vehicleData.vin = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the VIN';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: vehicleData.make,
            decoration: const InputDecoration(
              labelText: 'Make',
            ),
            onChanged: (value) => setState(() => vehicleData.make = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Make';
              }
              return null;
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
              return null;
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
              return null;
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
              return null;
            },
          ),
        ],
      ),
    ),
    Step(
      state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 1,
      title: const Text('Advance'),
      content: Column(
        children: [
          TextFormField(
            initialValue: vehicleData.licensePlateNumber,
            decoration:
            const InputDecoration(labelText: 'License Plate Number'),
            onChanged: (value) =>
                setState(() => vehicleData.licensePlateNumber = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the License Plate Number';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: vehicleData.engineType,
            decoration: const InputDecoration(
              labelText: 'Engine Type',
            ),
            onChanged: (value) =>
                setState(() => vehicleData.engineType = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Engine Type';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: vehicleData.fuelType,
            decoration: const InputDecoration(
              labelText: 'Fuel Type',
            ),
            onChanged: (value) => setState(() => vehicleData.fuelType = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Fuel Type';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: vehicleData.horsePower,
            decoration: const InputDecoration(
              labelText: 'Horse Power',
            ),
            onChanged: (value) => setState(() => vehicleData.horsePower = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Horse Power';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: vehicleData.transmission,
            decoration: const InputDecoration(
              labelText: 'Transmission',
            ),
            onChanged: (value) =>
                setState(() => vehicleData.transmission = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Transmission';
              }
              return null;
            },
          ),
        ],
      ),
    ),
    Step(
      state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 2,
      title: const Text('Photos'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageListView(),
            ElevatedButton(
              onPressed: _pickImages,
              child: const Text('Add Vehicle Images'),
            ),
            const SizedBox(height: 10),
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
        const SnackBar(content: Text('No logged-in user found')),
      );
      return;
    }

    // Encrypt the VIN before saving
    // String encryptedVin = EncryptionService.encryptText(vehicleData.vin);

    try {
      await vehicles.add({
        'userEmail': userEmail,
        'vin': vehicleData.vin, // Save encrypted VIN
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
        const SnackBar(
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
          content: Text('Failed to update vehicle details: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
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
    barrierDismissible: false, // Prevents the dialog from closing until we manually do it
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 24),
            const Text("Uploading data..."),
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
