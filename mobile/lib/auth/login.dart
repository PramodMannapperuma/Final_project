import 'package:flutter/material.dart';
import 'package:mobile/Home.dart';
import 'package:mobile/auth/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import '../nav/bottomNav.dart';

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
              "welcome Back",
              style: TextStyle(fontSize: 60),
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
                    onPressed: _login,
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
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
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
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        // Login successful, navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(), // Replace NextScreen() with your actual next screen widget
          ),
        );
      } catch (e) {
        // Handle login errors here
        print('Error: $e');
        // You can show an error message to the user if login fails
      }
    }
  }
}
