import 'package:flutter/material.dart';


class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 1.0;
  String _feedback = '';

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you can handle the submission, like sending data to a backend or showing a confirmation message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thank you!'),
          content: Text('Your feedback has been submitted successfully.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'How would you rate your experience?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Slider(
                value: _rating,
                onChanged: (newRating) {
                  setState(() => _rating = newRating);
                },
                min: 1.0,
                max: 5.0,
                divisions: 4,
                label: '$_rating',
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Share your feedback',
                  hintText: 'Tell us more about your experience',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _feedback = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your feedback';
                  }
                  return null;
                },
                maxLines: 5,
                minLines: 3,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  child: Text('Submit Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
