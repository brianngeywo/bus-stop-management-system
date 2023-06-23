import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class BusStationRegistrationScreen extends StatefulWidget {
  @override
  _BusStationRegistrationScreenState createState() =>
      _BusStationRegistrationScreenState();
}

class _BusStationRegistrationScreenState
    extends State<BusStationRegistrationScreen> {
  int _stationId = 0;
  String _name = '';
  String _location = '';
  List<int> _selectedSaccoIds = [];

  void _toggleSaccoSelection(int saccoId) {
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
        title: Text('Register Bus Station'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Station ID',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _stationId = int.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Station ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
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
              'Location',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _location = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Select Saccos',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: saccos.length,
              itemBuilder: (context, index) {
                SaccoModel sacco = saccos[index];
                bool isSelected = _selectedSaccoIds.contains(sacco.saccoId);
                return ListTile(
                  title: Text(sacco.name),
                  subtitle: Text(sacco.contactInfo),
                  leading: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      _toggleSaccoSelection(sacco.saccoId);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save action
                // Implement your logic here to save the bus station
                print('Station ID: $_stationId');
                print('Name: $_name');
                print('Location: $_location');
                print('Selected Sacco IDs: $_selectedSaccoIds');
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
