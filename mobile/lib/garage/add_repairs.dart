import 'package:flutter/material.dart';

class AddRepair extends StatefulWidget {
  const AddRepair({super.key});

  @override
  State<AddRepair> createState() => _AddRepairState();
}

class _AddRepairState extends State<AddRepair> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Repairs"),
      ),
      body: const Center(
        child: Text("Repairs"),
      ),
    );
  }
}
