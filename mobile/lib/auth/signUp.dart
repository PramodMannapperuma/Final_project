import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/auth/login.dart';
import 'package:bcrypt/bcrypt.dart';

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
        child: Column(children: [
          Form(
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
                  title: const Text(
                    'Personal Information',
                    style: TextStyle(color: Colors.blue),
                  ),
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
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
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
                  title: const Text(
                    'Account Information',
                    style: TextStyle(color: Colors.blue),
                  ),
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
                        decoration:
                            const InputDecoration(labelText: 'Password'),
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
                  title: const Text(
                    'Additional Information',
                    style: TextStyle(color: Colors.blue),
                  ),
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
                      child: Text(_currentStep == 2 ? 'SignUp' : 'Next'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Button background color
                        onPrimary: Colors.white, // Text and icon color on the button
                        elevation: 5, // Shadow elevation
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners with a circular radius
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Internal padding of the button
                      ),
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
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text("Already have an account? Login"),
          ),
        ]),
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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        String hashedPassword = BCrypt.hashpw(_password, BCrypt.gensalt());
        // Use Firebase Authentication to create a new user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // Optionally, save additional user details in Firestore
        User? user = userCredential.user;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'firstName': _firstName,
            'lastName': _lastName,
            'email': _email, // Consider omitting this if privacy is a concern
            'password': hashedPassword,
            'gender': _gender,
            'role': 'user',
            'userId': user.uid,
            // Add other fields as necessary
          });
        }

        // Navigate to another screen upon success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing up: ${e.toString()}')),
        );
      } catch (e) {
        // Handle any other errors
        print(e.toString());
      }
    }
  }
}
