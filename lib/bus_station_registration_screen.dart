import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/bus_station.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BusStationRegistrationScreen extends StatefulWidget {
  @override
  _BusStationRegistrationScreenState createState() =>
      _BusStationRegistrationScreenState();
}

class _BusStationRegistrationScreenState
    extends State<BusStationRegistrationScreen> {
  String _stationId = '';
  String _name = '';
  String _location = '';
  List<String> _selectedSaccoIds = [];

  void _toggleSaccoSelection(String saccoId) {
    setState(() {
      if (_selectedSaccoIds.contains(saccoId)) {
        _selectedSaccoIds.remove(saccoId);
      } else {
        _selectedSaccoIds.add(saccoId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Bus Station'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16.0),
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
              'Location',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
              'Select Saccos',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: saccos.length,
              itemBuilder: (context, index) {
                SaccoModel sacco = saccos[index];
                bool isSelected = _selectedSaccoIds.contains(sacco.saccoId);
                return ListTile(
                  title: Text(sacco.name),
                  subtitle: Text(sacco.phoneNumber),
                  leading: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      _toggleSaccoSelection(sacco.saccoId);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save action
                // Implement your logic here to save the bus station
                print('Station ID: $_stationId');
                print('Name: $_name');
                print('Location: $_location');
                print('Selected Sacco IDs: $_selectedSaccoIds');
                //create a new bus station object
                BusStationModel busStation = BusStationModel(
                  stationId: const Uuid().v4(),
                  name: _name,
                  location: _location,
                  saccoIds: _selectedSaccoIds,
                );
                //save the bus station to the firestore database
                busStationCollection.add(busStation.toMap());
                // show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bus Station Saved Successfully'),
                  ),
                );
                // clear the form
                setState(() {
                  _stationId = "";
                  _name = '';
                  _location = '';
                  _selectedSaccoIds = [];
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
