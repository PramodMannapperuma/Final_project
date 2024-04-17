import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehicleDetailsForm extends StatefulWidget {
  @override
  _VehicleDetailsFormState createState() => _VehicleDetailsFormState();
}

class _VehicleDetailsFormState extends State<VehicleDetailsForm> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _basicDetailsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _technicalDetailsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _ownershipKey = GlobalKey<FormState>();

  bool _isLoading = false;
  Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Page Vehicle Form"),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          BasicDetailsForm(formKey: _basicDetailsKey, formData: _formData),
          TechnicalDetailsForm(
              formKey: _technicalDetailsKey, formData: _formData),
          OwnershipForm(formKey: _ownershipKey, formData: _formData),
          buildSubmitPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (_pageController.page != 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                if (_pageController.page != 3) {  // Adjust based on the number of pages
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  _submitForm();  // Call submit on the last page
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubmitPage() {
    return Center(
      child: ElevatedButton(
        onPressed: _submitForm,
        child: Text('Submit All Details'),
      ),
    );
  }

  void _submitForm() async {
    // Validate all form states
    if (_basicDetailsKey.currentState?.validate() ?? false) {
      _basicDetailsKey.currentState?.save();
    }
    if (_technicalDetailsKey.currentState?.validate() ?? false) {
      _technicalDetailsKey.currentState?.save();
    }
    if (_ownershipKey.currentState?.validate() ?? false) {
      _ownershipKey.currentState?.save();
    }

    // Show a loading indicator
    setState(() {
      _isLoading = true;
    });

    // Send data to Firestore
    try {
      // Assuming you have a collection named 'vehicles'
      // You might want to generate a new document ID or use an existing one
      var docRef = FirebaseFirestore.instance
          .collection('vehicles')
          .doc(); // Creates a new doc
      await docRef.set(_formData);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vehicle details saved successfully!')));
    } catch (e) {
      print('Error updating data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save vehicle details: $e')));
    }

    // Hide loading indicator
    setState(() {
      _isLoading = false;
    });
  }
}

class BasicDetailsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  BasicDetailsForm({Key? key, required this.formKey, required this.formData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: formData['name'],
            decoration: InputDecoration(labelText: 'Vehicle Name'),
            onSaved: (value) => formData['name'] = value,
            validator: (value) =>
                value!.isEmpty ? 'This field cannot be empty' : null,
          ),
          TextFormField(
            initialValue: formData['model'],
            decoration: InputDecoration(labelText: 'Model'),
            onSaved: (value) => formData['model'] = value,
          ),
          // Add more fields as necessary
        ],
      ),
    );
  }
}

class TechnicalDetailsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  TechnicalDetailsForm(
      {Key? key, required this.formKey, required this.formData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: formData['engineType'],
            decoration: InputDecoration(labelText: 'Engine Type'),
            onSaved: (value) => formData['engineType'] = value,
            validator: (value) =>
                value!.isEmpty ? 'This field cannot be empty' : null,
          ),
          TextFormField(
            initialValue: formData['fuelType'],
            decoration: InputDecoration(labelText: 'Fuel Type'),
            onSaved: (value) => formData['fuelType'] = value,
          ),
          // Add more technical fields as necessary
        ],
      ),
    );
  }
}

class OwnershipForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  OwnershipForm({Key? key, required this.formKey, required this.formData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: formData['ownerName'],
            decoration: InputDecoration(labelText: 'Owner Name'),
            onSaved: (value) => formData['ownerName'] = value,
            validator: (value) =>
                value!.isEmpty ? 'This field cannot be empty' : null,
          ),
          TextFormField(
            initialValue: formData['contactInfo'],
            decoration: InputDecoration(labelText: 'Contact Info'),
            onSaved: (value) => formData['contactInfo'] = value,
          ),
          // Add more ownership fields as necessary
        ],
      ),
    );
  }
}
