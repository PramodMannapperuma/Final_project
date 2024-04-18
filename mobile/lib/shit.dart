// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobile/screens/profile_edit.dart';
// import 'dart:io';
//
// class VehicleDetailsForm extends StatefulWidget {
//   @override
//   _VehicleDetailsFormState createState() => _VehicleDetailsFormState();
// }
//
// class _VehicleDetailsFormState extends State<VehicleDetailsForm> {
//   final PageController _pageController = PageController();
//   final GlobalKey<FormState> _basicDetailsKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _technicalDetailsKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _ownershipKey = GlobalKey<FormState>();
//
//   bool _isLoading = false;
//   Map<String, dynamic> _formData = {};
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Multi-Page Vehicle Form"),
//       ),
//       body: PageView(
//         controller: _pageController,
//         children: <Widget>[
//           BasicDetailsForm(
//             formKey: _basicDetailsKey,
//             onSave: (value, field) {
//               if (value != null) _formData[field] = value;
//             },
//           ),
//           TechnicalDetailsForm(
//             formKey: _technicalDetailsKey, formData: _formData, onSave: (String? value, String field) {  },),
//           OwnershipForm(formKey: _ownershipKey, formData: _formData, onSave: (String? value, String field) {  },),
//           buildSubmitPage(),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 if (_pageController.page != 0) {
//                   _pageController.previousPage(
//                     duration: Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                   );
//                 }
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.arrow_forward),
//               onPressed: () {
//                 if (_pageController.page != 3) {
//                   // Adjust based on the number of pages
//                   _pageController.nextPage(
//                     duration: Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                   );
//                 } else {
//                   _submitForm(); // Call submit on the last page
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildSubmitPage() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: _submitForm,
//         child: Text('Submit All Details'),
//       ),
//     );
//   }
//
//   void _submitForm() async {
//     bool isFormValid = true;
//
//     // // Validate and save each form
//     // if (_basicDetailsKey.currentState?.validate() ?? false) {
//     //   _basicDetailsKey.currentState!.save();
//     // } else {
//     //   print("Basic details form is invalid");
//     //   isFormValid = false;
//     // }
//     // if (_technicalDetailsKey.currentState?.validate() ?? false) {
//     //   _technicalDetailsKey.currentState!.save();
//     // } else {
//     //   print("Technical details form is invalid");
//     //   isFormValid = false;
//     // }
//     // if (_ownershipKey.currentState?.validate() ?? false) {
//     //   _ownershipKey.currentState!.save();
//     // } else {
//     //   print("Ownership form is invalid");
//     //   isFormValid = false;
//     // }
//     //
//     // if (!isFormValid) {
//     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     //       content: Text('Please correct form errors before submitting.')));
//     //   return;
//     // }
//
//     // Show a loading indicator
//     setState(() {
//       _isLoading = true;
//     });
//
//     // Send data to Firestore
//     try {
//       var docRef = FirebaseFirestore.instance.collection('vehicles').doc();
//       await docRef.set(_formData);
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Vehicle details saved successfully!')));
//     } catch (e) {
//       print('Error updating data: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to save vehicle details: $e')));
//     }
//
//     // Hide loading indicator
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }
//
// class BasicDetailsForm extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final Function(String? value, String field) onSave;
//
//   BasicDetailsForm({Key? key, required this.formKey, required this.onSave})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: <Widget>[
//               ProfileDetailColumnEdit(
//                 title: 'Vehicle Identification Number',
//                 initialValue: '',
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'vin');
//                   print("Saved $value for vin");
//                 },
//               ),
//               ProfileDetailColumnEdit(
//                 title: 'Make',
//                 initialValue: 'Shelby',
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'make');
//                 },
//               ),
//               ProfileDetailColumnEdit(
//                 title: 'Model',
//                 initialValue: 'Shelby',
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'model');
//                 },
//               ),
//               ProfileDetailColumnEdit(
//                 title: 'Year',
//                 initialValue: 'Shelby',
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'year');
//                 },
//               ),
//               ProfileDetailColumnEdit(
//                 title: 'Color',
//                 initialValue: 'Shelby',
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'color');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TechnicalDetailsForm extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final Map<String, dynamic> formData;
//   final Function(String? value, String field) onSave;
//
//   TechnicalDetailsForm(
//       {Key? key,
//         required this.formKey,
//         required this.formData,
//         required this.onSave})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: <Widget>[
//               ProfileDetailColumnEdit(
//                 title: "License Plate Number",
//                 initialValue: "initialValue",
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'pltnumber');
//                 },
//               ),
//               ProfileDetailColumnEdit(
//                 title: "Engine Type",
//                 initialValue: "initialValue",
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'etype');
//                 },
//               ),
//               ProfileDetailColumnEdit(
//                 title: "Fuel Type",
//                 initialValue: "initialValue",
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'fueltype');
//                 },
//               ),
//               ProfileDetailColumnEdit(
//                 title: "Horse Power",
//                 initialValue: "initialValue",
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'hpower');
//                 },
//               ),
//               ProfileDetailColumnEdit(
//                 title: "Transmission",
//                 initialValue: "initialValue",
//                 onSaved: (String? value) {
//                   if (value != null) onSave(value, 'transmission');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class OwnershipForm extends StatefulWidget {
//   final GlobalKey<FormState> formKey;
//   final Map<String, dynamic> formData;
//   final Function(String? value, String field) onSave;
//
//   OwnershipForm(
//       {Key? key,
//         required this.formKey,
//         required this.formData,
//         required this.onSave})
//       : super(key: key);
//
//   @override
//   _OwnershipFormState createState() => _OwnershipFormState();
// }
//
// class _OwnershipFormState extends State<OwnershipForm> {
//   List<File> _vehicleImages = []; // List to hold selected images
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickImage() async {
//     final List<XFile>? selectedImages = await _picker.pickMultiImage();
//     if (selectedImages != null) {
//       setState(() {
//         _vehicleImages
//             .addAll(selectedImages.map((xFile) => File(xFile.path)).toList());
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: widget.formKey,
//           child: Column(
//             children: <Widget>[
//               for (var imageFile in _vehicleImages)
//                 Container(
//                   height: 100,
//                   width: 100,
//                   margin: EdgeInsets.only(bottom: 8),
//                   child: Image.file(imageFile, fit: BoxFit.cover),
//                 ),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('Add Images'),
//               ),
//               // Existing input fields...
//               ProfileDetailColumnEdit(
//                 title: "Owner Name",
//                 initialValue: 'initial value',
//                 onSaved: (String? value) {
//                   if (value != null) widget.onSave(value, 'ownername');
//                 },
//               ),
//               ProfileDetailColumnEdit(
//                 title: 'City',
//                 initialValue: 'initial',
//                 onSaved: (String? value) {if (value != null) widget.onSave(value, 'city');},
//               ),
//               ProfileDetailColumnEdit(
//                 title: "Contact",
//                 initialValue: 'initial',
//                 onSaved: (String? value) {if (value != null) widget.onSave(value, 'conatct');},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
