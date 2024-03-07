import 'package:flutter/material.dart';
import 'package:mobile_app/auth/login.dart';
import 'package:mobile_app/auth/signUp.dart';
import 'package:mobile_app/nav/bottomNav.dart';
// import 'package:mobile_app/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,

      ),
      home: SignupScreen(),
    );
  }
}
