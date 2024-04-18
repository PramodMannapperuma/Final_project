import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleEdit extends StatefulWidget {
  final String vehicleId; // Assuming each vehicle has a unique ID

  const VehicleEdit({Key? key, required this.vehicleId}) : super(key: key);

  @override
  State<VehicleEdit> createState() => _VehicleEditState();
}

class _VehicleEditState extends State<VehicleEdit> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Map<String, dynamic> _formData = {
    'name': '',
    'registrationNumber': '',
    'model': '',
    'color': '',
    'year': '',
  };

  @override
  void initState() {
    super.initState();
    _loadVehicleData();
  }

  Future<void> _loadVehicleData() async {
    setState(() => _isLoading = true);
    try {
      var document = await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(widget.vehicleId)
          .get();
      if (document.exists) {
        _formData = document.data()!;
        setState(() {});
      }
    } catch (e) {
      print("Error loading data: $e");
    }
    setState(() => _isLoading = false);
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);
      try {
        await FirebaseFirestore.instance
            .collection('vehicles')
            .doc(widget.vehicleId)
            .update(_formData);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Vehicle details updated successfully!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update vehicle details')));
        print("Error updating data: $e");
      }
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Vehicle Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Background cover photo
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/Images/cv.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Circle avatar
                            Positioned(
                              bottom: 0, // Adjust the bottom position as needed
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/Images/well.jpg"),
                                radius: 60,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: const Divider(
                          thickness: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Shelby GT500',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: _formData['description'],
                              decoration: InputDecoration(
                                labelText: 'Description',
                              ),
                              onSaved: (value) =>
                                  _formData['description'] = value ?? '',
                              validator: (value) => value!.isEmpty
                                  ? 'This Field Cannot be Empty'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      ProfileDetailColumnEdit(
                          title: 'Vehicle Identification Number (VIN)', initialValue: '',onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                      ProfileDetailColumnEdit(
                          title: 'Make', initialValue: '',onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                      ProfileDetailColumnEdit(
                          title: 'Model', initialValue: '',onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                      ProfileDetailColumnEdit(
                          title: 'Year', initialValue: '', onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                      ProfileDetailColumnEdit(
                          title: 'Color', initialValue: '', onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                      ProfileDetailColumnEdit(
                          title: 'License Plate Number', initialValue: '', onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                      ProfileDetailColumnEdit(
                          title: 'Engine Type', initialValue: '' ,onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                      ProfileDetailColumnEdit(
                          title: 'Fuel Type', initialValue: '',onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                      ProfileDetailColumnEdit(
                          title: 'Horse Power', initialValue: '', onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                      ProfileDetailColumnEdit(
                          title: 'Transmission', initialValue: '',onSaved: (String? value) { setState(() => _formData['vin'] = value ?? ''); },),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class ProfileDetailColumnEdit extends StatefulWidget {
  final String title;
  final String initialValue;
  final Function(String? value) onSaved;

  const ProfileDetailColumnEdit(
      {Key? key, required this.title, required this.initialValue, required this.onSaved})
      : super(key: key);

  @override
  _ProfileDetailColumnEditState createState() =>
      _ProfileDetailColumnEditState();
}

class _ProfileDetailColumnEditState extends State<ProfileDetailColumnEdit> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() {
      print("Current Value: ${_controller.text}");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter ${widget.title}',
                  border: UnderlineInputBorder(),
                ),
                onSaved: (value) => widget.onSaved(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),

            ],
          ),
        ),
        const Icon(
          Icons.edit,
          size: 15.0,
        ),
      ],
    );
  }
}
