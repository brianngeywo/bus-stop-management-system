import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class DriverRegistrationScreen extends StatefulWidget {
  @override
  _DriverRegistrationScreenState createState() =>
      _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  String _name = '';
  String _contactInfo = '';
  SaccoModel? _selectedSacco;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 16.0),
            Text(
              'Sacco',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            DropdownButton<SaccoModel>(
              value: _selectedSacco,
              onChanged: (value) {
                setState(() {
                  _selectedSacco = value!;
                });
              },
              items: saccos.map((sacco) {
                return DropdownMenuItem<SaccoModel>(
                  value: sacco,
                  child: Text(sacco.name),
                );
              }).toList(),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Save the Driver details and navigate to the next screen
                // or perform any desired action
                if (_selectedSacco != null) {
                  final driver = DriverModel(
                    name: _name,
                    contactInfo: _contactInfo,
                    saccoId: _selectedSacco!.saccoId,
                    driverId: drivers.length + 1,
                  );

                  // Save the driver details or perform any desired action
                  // ...

                  // Navigate to the next screen
                  // ...
                }
              },
              child: const Text('Register Driver'),
            ),
          ],
        ),
      ),
    );
  }
}
