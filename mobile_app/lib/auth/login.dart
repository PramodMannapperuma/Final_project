import 'package:flutter/material.dart';
import 'package:mobile_app/Home.dart';
import 'package:mobile_app/nav/bottomNav.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(0.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Shit",
              style: TextStyle(fontSize: 80),
            ),
            // Image.asset(
            //   'assets/Images/shit.jpg',
            //   width: 400, // Set the width of the image
            //   height: 100, // Set the height of the image
            // ),
            const SizedBox(
                height: 16), // Add some space between the image and the form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 16)),
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 16)),
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // You can add your login logic here using _email and _password
                        print('Email: $_email');
                        print('Password: $_password');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavbar(),
                          ), // Replace HomePage with your actual homepage widget
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.blue, // Set the text color of the button
                      minimumSize: const Size(double.infinity,
                          50), // Set the minimum size of the button (width, height)
                      padding: const EdgeInsets.symmetric(
                          vertical: 16), // Set the padding inside the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set the border radius
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 16), // Set the font size of the button text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
