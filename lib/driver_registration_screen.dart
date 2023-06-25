import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DriverRegistrationScreen extends StatefulWidget {
  @override
  _DriverRegistrationScreenState createState() =>
      _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  String _name = '';
  String _contactInfo = '';
  SaccoModel? _selectedSacco;
  List<SaccoModel> saccos = [];
  @override
  void initState() {
    // TODO: implement initState
    saccos = getAllSaccosFromFirestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Contact Info',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _contactInfo = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter Contact Info',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Sacco',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
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
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Save the Driver details and navigate to the next screen
                // or perform any desired action
                if (_selectedSacco != null) {
                  final driver = DriverModel(
                    name: _name,
                    contactInfo: _contactInfo,
                    saccoId: _selectedSacco!.saccoId,
                    driverId: const Uuid().v4(),
                  );

                  // Save the driver details to firestore database
                  driversCollection.doc(driver.driverId).set(driver.toMap());
                  //show a snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Driver registered successfully'),
                    ),
                  );
                }
              },
              child: const Text('Register Driver'),
            ),
          ],
        ),
      ),
    );
  }

  List<SaccoModel> getAllSaccosFromFirestore() {
    saccoCollection.get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        final sacco = SaccoModel.fromMap(doc.data());
        setState(() {
          saccos.add(sacco);
        });
      });
    });
    return saccos;
  }
}
