import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class BusRegistrationScreen extends StatefulWidget {
  @override
  _BusRegistrationScreenState createState() => _BusRegistrationScreenState();
}

class _BusRegistrationScreenState extends State<BusRegistrationScreen> {
  int _busId = 0;
  String _numberPlate = '';
  int _selectedRouteId = 0;
  int _selectedSaccoId = 0;
  int _selectedDriverId = 0;
  List<int> _selectedRoutes = [];
  List<int> _selectedSaccos = [];
  List<int> _selectedDrivers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bus ID',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _busId = int.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Bus ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Number Plate',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _numberPlate = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Number Plate',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Routes',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: _buildRouteChips(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Sacco',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: _buildSaccoChips(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Driver',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: _buildDriverChips(),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Save the Bus details and navigate to the next screen
                // or perform any desired action

                // Print the selected bus details for testing
                print('Bus ID: $_busId');
                print('Number Plate: $_numberPlate');
                print('Selected Routes: $_selectedRoutes');
                print('Selected Sacco ID: $_selectedSaccoId');
                print('Selected Driver ID: $_selectedDriverId');
              },
              child: Text('Register Bus'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRouteChips() {
    return busRoutes.map((route) {
      final isSelected = _selectedRoutes.contains(route.routeId);
      return ChoiceChip(
        label: Text(route.source + ' - ' + route.destination),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedRoutes.add(route.routeId);
            } else {
              _selectedRoutes.remove(route.routeId);
            }
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildSaccoChips() {
    return saccos.map((sacco) {
      final isSelected = _selectedSaccoId == sacco.saccoId;
      return ChoiceChip(
        label: Text(sacco.name),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedSaccoId = sacco.saccoId;
            } else {
              _selectedSaccoId = 0;
            }
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildDriverChips() {
    return drivers.map((driver) {
      final isSelected = _selectedDriverId == driver.driverId;
      return ChoiceChip(
        label: Text('Driver ${driver.name}'),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedDriverId = driver.driverId;
            } else {
              _selectedDriverId = 0;
            }
          });
        },
      );
    }).toList();
  }
}
