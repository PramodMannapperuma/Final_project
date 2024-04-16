import 'package:flutter/material.dart';

class RquestReport extends StatefulWidget {
  const RquestReport({super.key});

  @override
  State<RquestReport> createState() => _RquestReportState();
}

class _RquestReportState extends State<RquestReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Request"),
      ),
      body: Text("Report Request"),
    );
  }
}
