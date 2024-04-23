import 'package:flutter/material.dart';

class CheckAccidents extends StatefulWidget {
  const CheckAccidents({super.key});

  @override
  State<CheckAccidents> createState() => _CheckAccidentsState();
}

class _CheckAccidentsState extends State<CheckAccidents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accidents"),
      ),
      body: const Center(
        child: Text("Accidents"),
      ),
    );
  }
}
