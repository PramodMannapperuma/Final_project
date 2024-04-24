import 'package:flutter/material.dart';


class CheckRepairs extends StatefulWidget {
  const CheckRepairs({super.key});

  @override
  State<CheckRepairs> createState() => _CheckRepairsState();
}

class _CheckRepairsState extends State<CheckRepairs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repairs"),
      ),
      body: const Center(
        child: Text("Repairs"),
      ),
    );
  }
}
