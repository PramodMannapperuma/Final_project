import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PdfFilePicker extends StatefulWidget {
  @override
  _PdfFilePickerState createState() => _PdfFilePickerState();
}

class _PdfFilePickerState extends State<PdfFilePicker> {
  String? _insuranceFileName;
  String? _ecoTestFileName;

  void _openFilePicker(String fileType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        String? fileName = result.files.single.name;
        String? filePath = result.files.single.path;

        setState(() {
          if (fileType == 'insurance') {
            _insuranceFileName = fileName;
          } else if (fileType == 'ecoTest') {
            _ecoTestFileName = fileName;
          }
        });
      } else {
        print("User canceled the file picking.");
      }
    } catch (e) {
      print("Error while picking the file: $e");
    }
  }

  void _uploadFiles() {
    if (_insuranceFileName != null && _ecoTestFileName != null) {
      // Implement your upload logic here
      print('Uploading Insurance File: $_insuranceFileName');
      print('Uploading Eco Test File: $_ecoTestFileName');
    } else {
      print('Please select both files to upload.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF File Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _openFilePicker('insurance'),
              child: Text('Add Insurance'),
            ),
            SizedBox(height: 20),
            if (_insuranceFileName != null)
              Text('Insurance File: $_insuranceFileName'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _openFilePicker('ecoTest'),
              child: Text('Add Eco Test'),
            ),
            SizedBox(height: 20),
            if (_ecoTestFileName != null)
              Text('Eco Test File: $_ecoTestFileName'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFiles,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}