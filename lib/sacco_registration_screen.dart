import 'package:flutter/material.dart';

class SaccoRegistrationScreen extends StatefulWidget {
  @override
  _SaccoRegistrationScreenState createState() =>
      _SaccoRegistrationScreenState();
}

class _SaccoRegistrationScreenState extends State<SaccoRegistrationScreen> {
  String _name = '';
  String _contactInfo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sacco Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Info',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _contactInfo = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Contact Info',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Save the Sacco details and navigate to the next screen
                // or perform any desired action
              },
              child: Text('Register Sacco'),
            ),
          ],
        ),
      ),
    );
  }
}
