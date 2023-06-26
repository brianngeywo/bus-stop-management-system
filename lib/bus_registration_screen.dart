import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/main_app_bar.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'models/driver_model.dart';

class BusRegistrationScreen extends StatefulWidget {
  @override
  _BusRegistrationScreenState createState() => _BusRegistrationScreenState();
}

class _BusRegistrationScreenState extends State<BusRegistrationScreen> {
  String _busId = '';
  String _numberPlate = '';
  String _selectedRouteId = '';
  String _selectedSaccoId = "";
  String _selectedDriverId = "";
  List<BusRouteModel> busRoutes = [];
  List<SaccoModel> saccos = [];
  List<DriverModel> drivers = [];
  void ferchAllData() async {
    busRoutes = await fetchBusRoutes();
    saccos = await fetchAllSaccos();
    drivers = await fetchAllDrivers();
  }

  @override
  void initState() {
    // TODO: implement initState
    ferchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Bus Registration'),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TranspoLink Bus Registration',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Number Plate',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _numberPlate = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Number Plate',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Routes',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: _buildRouteChips(),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Sacco',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: _buildSaccoChips(),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Driver',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: _buildDriverChips(),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan[900],
                    ),
                    onPressed: () {
                      // Create new bus object
                      final bus = BusModel(
                        busId: const Uuid().v4(),
                        numberPlate: _numberPlate,
                        saccoId: _selectedSaccoId,
                        driverId: _selectedDriverId,
                        routeId: _selectedRouteId,
                      );

                      // Print the selected bus details for testing
                      print('Bus ID: $_busId');
                      print('Number Plate: $_numberPlate');
                      print('Selected Routes: $_selectedRouteId');
                      print('Selected Sacco ID: $_selectedSaccoId');
                      print('Selected Driver ID: $_selectedDriverId');

                      //save bus to firestore
                      busesCollection.doc(bus.busId).set(bus.toMap());
                      // Clear the form
                      setState(() {
                        _busId = '';
                        _numberPlate = '';
                        _selectedSaccoId = "";
                        _selectedRouteId = "";
                        _selectedDriverId = "";
                      });
                      // Show a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bus registered successfully'),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Register Bus',
                          style: TextStyle(color: Colors.white)),
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

  List<Widget> _buildRouteChips() {
    return busRoutes.map((route) {
      final isSelected = _selectedRouteId == route.routeId;
      return ChoiceChip(
        label: Text(
          route.source + ' - ' + route.destination,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        selectedColor: Colors.cyan[900],
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedRouteId = route.routeId;
            } else {
              _selectedRouteId = "";
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
        label: Text(sacco.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        selectedColor: Colors.cyan[900],
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedSaccoId = sacco.saccoId;
            } else {
              _selectedSaccoId = "";
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
        label: Text(
          'Driver ${driver.name}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        selectedColor: Colors.cyan[900],
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedDriverId = driver.driverId;
            } else {
              _selectedDriverId = "";
            }
          });
        },
      );
    }).toList();
  }

  Future<List<DriverModel>> fetchAllDrivers() async {
    List<DriverModel> my_drivers = [];
    final drivers = await driversCollection.get();
    setState(() {
      for (var driver in drivers.docs) {
        my_drivers.add(DriverModel.fromMap(driver.data()));
      }
    });
    return my_drivers;
  }

  Future<List<SaccoModel>> fetchAllSaccos() async {
    List<SaccoModel> my_saccos = [];
    final saccos = await saccoCollection.get();
    setState(() {
      saccos.docs.forEach((sacco) {
        my_saccos.add(SaccoModel.fromMap(sacco.data()));
      });
    });
    return my_saccos;
  }

  Future<List<BusRouteModel>> fetchBusRoutes() async {
    List<BusRouteModel> busRoutes = [];
    final routes = await busRoutesCollection.get();
    setState(() {
      routes.docs.forEach((route) {
        busRoutes.add(BusRouteModel.fromMap(route.data()));
      });
    });
    return busRoutes;
  }
}
