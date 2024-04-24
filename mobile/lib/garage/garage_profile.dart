import 'package:flutter/material.dart';

class GarageProfile extends StatefulWidget {
  const GarageProfile({super.key});

  @override
  State<GarageProfile> createState() => _GarageProfileState();
}

class _GarageProfileState extends State<GarageProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Garage Profile"),
      ),
      body: const Center(
        child: Text("Garage Profile"),
      ),
    );
  }
}
