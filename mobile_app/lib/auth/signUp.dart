import 'package:flutter/material.dart';
import 'package:mobile_app/nav/bottomNav.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String? _gender;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          // autovalidateMode: AutovalidateMode.always, // Use _autovalidateMode here
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: () {
              setState(() {
                if (_validateCurrentStep()) {
                  if (_currentStep < 2) {
                    _currentStep++;

                    // Reset autovalidation when moving to the next step
                  }
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (_currentStep > 0) {
                  _currentStep--;
                  // Reset autovalidation when moving to the previous step
                }
              });
            },
            steps: [
              Step(
                title: const Text('Personal Information'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: (value) {
                        if (_currentStep == 0 &&
                            (value == null || value.isEmpty)) {

                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _firstName = value!;
                      },
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (value) {
                        if (_currentStep == 0 &&
                            (value == null || value.isEmpty)) {

                          return 'Please enter your last name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _lastName = value!;
                      },
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text('Account Information'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (_currentStep == 1 &&
                            (value == null || value.isEmpty)) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (_currentStep == 1 &&
                            (value == null || value.isEmpty)) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text('Additional Information'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Gender'),
                      value: _gender,
                      items: const [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Other'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                      validator: (value) {
                        if (_currentStep == 3 &&
                            (value == null || value.isEmpty)) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
            controlsBuilder:
                (BuildContext context, ControlsDetails controlsDetails) {
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Check if the current step is valid
                      if (_formKey.currentState!.validate()) {
                        // If it's the last step, submit the form
                        if (_currentStep == 2) {
                          _submitForm();
                        } else {
                          // Otherwise, move to the next step
                          setState(() {
                            _currentStep++;
                          });
                        }
                      }
                    },
                    child: Text(_currentStep == 2 ? 'Finish' : 'Next'),
                  ),
                  const SizedBox(width: 16),
                  if (_currentStep > 0)
                    TextButton(
                      onPressed: controlsDetails.onStepCancel,
                      child: const Text('Back'),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        // Validate fields in the first step
        if (_firstNameController.text.isEmpty ||
            _lastNameController.text.isEmpty) {
          return false;
        }
        break;
      case 1:
        // Validate fields in the second step
        if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
          return false;
        }
        break;
      case 2:
        // Validate fields in the third step
        if (_gender == null) {
          return false;
        }
        break;
    }
    return true;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Perform form submission
      print('First Name: $_firstName');
      print('Last Name: $_lastName');
      print('Email: $_email');
      print('Password: $_password');
      print('Gender: $_gender');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavbar(),
        ), // Replace HomePage with your actual homepage widget
      );
      // You can perform any additional actions here, such as submitting the data to a server
    }
  }
}
