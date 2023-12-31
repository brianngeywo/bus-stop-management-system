import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'main_app_bar.dart';

class SaccoRegistrationScreen extends StatefulWidget {
  @override
  _SaccoRegistrationScreenState createState() =>
      _SaccoRegistrationScreenState();
}

class _SaccoRegistrationScreenState extends State<SaccoRegistrationScreen> {
  int _saccoId = 0;
  String _name = '';
  String _location = '';
  String _phoneNumber = '';
  String _emailAddress = '';
  String _openingTime = '';
  String _closingTime = '';
  List<String> _activeDays = [];

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Sacco Registration'),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sacco Registration Form',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Divider(),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Name',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                    'Location',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _location = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Phone Number',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Email Address',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _emailAddress = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Email Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Active hours',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _openingTime = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Opening Time',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _closingTime = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Closing Time',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Active Days',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Column(
                    children: _daysOfWeek.map((day) {
                      return CheckboxListTile(
                        title: Text(day),
                        value: _activeDays.contains(day),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              _activeDays.add(day);
                            } else {
                              _activeDays.remove(day);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan[900],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0,
                      ),
                    ),
                    onPressed: () {
                      // Create a new SaccoModel instance and save the details
                      SaccoModel newSacco = SaccoModel(
                        saccoId: const Uuid().v4(),
                        name: _name,
                        location: _location,
                        phoneNumber: _phoneNumber,
                        emailAdress: _emailAddress,
                        openingTime: _openingTime,
                        closingTime: _closingTime,
                        activeDays: _activeDays,
                      );
                      // Save the new sacco to the firestore
                      saccoCollection
                          .doc(newSacco.saccoId)
                          .set(newSacco.toMap());

                      // show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sacco Registered Successfully'),
                        ),
                      );
                      // clear the text fields
                      setState(() {
                        _saccoId = 0;
                        _name = '';
                        _location = '';
                        _phoneNumber = '';
                        _emailAddress = '';
                        _openingTime = '';
                        _closingTime = '';
                        _activeDays = [];
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Register Sacco',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
