import 'package:flutter/material.dart';

class RevenueRequest extends StatefulWidget {
  const RevenueRequest({super.key});

  @override
  State<RevenueRequest> createState() => _RevenueRequestState();
}

class _RevenueRequestState extends State<RevenueRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rev'),
      ),
      body: Text("Rev"),
    );
  }
}
