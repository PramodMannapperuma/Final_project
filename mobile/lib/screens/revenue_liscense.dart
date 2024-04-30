import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:math';

class PdfFilePicker extends StatefulWidget {
  const PdfFilePicker({Key? key}) : super(key: key);

  @override
  _PdfFilePickerState createState() => _PdfFilePickerState();
}

class _PdfFilePickerState extends State<PdfFilePicker> {
  String? _insuranceFileName;
  String? _ecoTestFileName;
  String? _certificateFileName;
  String? _insuranceUrl;
  String? _ecoTestUrl;
  String? _certificateUrl;

  PlatformFile? _insuranceFile;
  PlatformFile? _ecoTestFile;
  PlatformFile? _certificateFile;
  bool _uploading = false; // Added to track uploading state

  Future<Map<String, dynamic>?> getVehicleData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('userEmail', isEqualTo: user.email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first
            .data(); // Assuming this contains all necessary vehicle data
      }
    }
    return null; // No vehicle data or user not logged in
  }

  Future<void> _openFilePicker(String fileType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        setState(() {
          if (fileType == 'insurance') {
            _insuranceFileName = file.name;
            _insuranceFile = file;
          } else if (fileType == 'ecoTest') {
            _ecoTestFileName = file.name;
            _ecoTestFile = file;
          } else if (fileType == 'certificate') {
            _certificateFileName = file.name;
            _certificateFile = file;
          }
        });
      } else {
        print("User canceled the file picking.");
      }
    } catch (e) {
      print("Error while picking the file: $e");
    }
  }

  String generateId() {
    Random random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    String id = '';
    for (int i = 0; i < 7; i++) {
      id += chars[random.nextInt(chars.length)];
    }
    return id;
  }

  Future<void> _uploadFiles() async {
    if (_insuranceFile != null &&
        _ecoTestFile != null &&
        _certificateFile != null) {
      setState(() {
        _uploading = true; // Start uploading, show loading screen
      });

      try {
        firebase_storage.FirebaseStorage storage =
            firebase_storage.FirebaseStorage.instance;

        String id = generateId();
        // Upload insurance file
        firebase_storage.Reference insuranceRef =
            storage.ref('documents/$id/$_insuranceFileName');
        firebase_storage.UploadTask insuranceUploadTask = insuranceRef.putFile(
          File(_insuranceFile!.path!),
        );
        _insuranceUrl = await (await insuranceUploadTask).ref.getDownloadURL();

        // Upload ecoTest file
        firebase_storage.Reference ecoTestRef =
            storage.ref('documents/$id/$_ecoTestFileName');
        firebase_storage.UploadTask ecoTestUploadTask = ecoTestRef.putFile(
          File(_ecoTestFile!.path!),
        );
        _ecoTestUrl = await (await ecoTestUploadTask).ref.getDownloadURL();

        // Upload certificate file
        firebase_storage.Reference certificateRef =
            storage.ref('documents/$id/$_certificateFileName');
        firebase_storage.UploadTask certificateUploadTask =
            certificateRef.putFile(
          File(_certificateFile!.path!),
        );
        _certificateUrl =
            await (await certificateUploadTask).ref.getDownloadURL();

        // Save URLs to Firestore and get collection ID
        String collectionId = await saveUrlsToFirestore(
            _insuranceUrl!, _ecoTestUrl!, _certificateUrl!, id);
        await saveUrlsToVehicles(
            collectionId, _insuranceUrl!, _ecoTestUrl!, _certificateUrl!);

        // Show collection ID
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Reference Number'),
              content:
                  Text('Your files are uploaded. Collection ID: $collectionId'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Clear file names and files
        setState(() {
          _insuranceFileName = null;
          _ecoTestFileName = null;
          _certificateFileName = null;
          _insuranceFile = null;
          _ecoTestFile = null;
          _certificateFile = null;
          _uploading = false; // Stop uploading, hide loading screen
        });
      } catch (e) {
        print("Error uploading files: $e");
        setState(() {
          _uploading = false; // Stop uploading, hide loading screen on error
        });
      }
    } else {
      print('Please select all files to upload.');
    }
  }

  Future<void> saveUrlsToVehicles(String collectionId, String insuranceUrl,
      String ecoTestUrl, String certificateUrl) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email != null) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
            .collection('vehicles')
            .where('userEmail', isEqualTo: user.email)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          DocumentSnapshot<Map<String, dynamic>> docSnapshot = snapshot.docs.first;
          String docId = docSnapshot.id;
          DocumentReference docRef = firestore.collection('vehicles').doc(docId);

          Map<String, dynamic> updatedData = {
            'collectionId': collectionId,
            'insuranceUrl': insuranceUrl,
            'ecoTestUrl': ecoTestUrl,
            'certificateUrl': certificateUrl,
          };

          await docRef.update(updatedData);
          print("File URLs updated successfully in vehicles collection.");
        } else {
          print("Error: No vehicle data found for user.");
        }
      } else {
        print("Error: User not logged in or email not available.");
      }
    } catch (error) {
      print("Error updating file URLs in vehicles collection: $error");
    }
  }

  Future<String> saveUrlsToFirestore(String insuranceUrl, String ecoTestUrl,
      String certificateUrl, String id) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference docRef = await firestore.collection('fileIds').doc(id);

      // Get vehicle data
      Map<String, dynamic>? vehicleData = await getVehicleData();

      if (vehicleData != null) {
        // Merge vehicle data with URLs
        Map<String, dynamic> data = {
          'insuranceUrl': insuranceUrl,
          'ecoTestUrl': ecoTestUrl,
          'certificateUrl': certificateUrl,
          'vehicleData': vehicleData, // Add vehicle data here
        };

        await docRef.set(data);
        print("File URLs and vehicle data uploaded successfully!");
      } else {
        print("Error: No vehicle data found.");
      }

      return docRef.id; // Return the collection ID
    } catch (error) {
      print("Error uploading file URLs and vehicle data: $error");
      return ''; // Return empty string on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue License'),
      ),
      body: _uploading
          ? Center(
              child: CircularProgressIndicator(), // Loading indicator
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _openFilePicker('insurance'),
                    child: const Text('Add Insurance'),
                  ),
                  if (_insuranceFileName != null)
                    Text('Insurance File: $_insuranceFileName'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _openFilePicker('ecoTest'),
                    child: const Text('Add Eco Test'),
                  ),
                  if (_ecoTestFileName != null)
                    Text('Eco Test File: $_ecoTestFileName'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _openFilePicker('certificate'),
                    child: const Text('Add Certificate'),
                  ),
                  if (_certificateFileName != null)
                    Text('Certificate File: $_certificateFileName'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _uploadFiles,
                    child: const Text('Upload'),
                  ),
                ],
              ),
            ),
    );
  }
}
