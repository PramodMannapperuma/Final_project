import 'package:flutter/material.dart';

class AddAccidents extends StatefulWidget {
  const AddAccidents({super.key});

  @override
  State<AddAccidents> createState() => _AddAccidentsState();
}

class _AddAccidentsState extends State<AddAccidents> {
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
