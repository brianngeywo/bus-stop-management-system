import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/bus_station.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'main_app_bar.dart';

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
  List<SaccoModel> _saccos = [];

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
  void initState() {
    // TODO: implement initState
    fetchSaccos();
    super.initState();
  }

  void fetchSaccos() async {
    _saccos = getAllSaccosFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('Register Bus Station'),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const Text(
                      'TranspoLink Bus Station Registration',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
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
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
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
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    StreamBuilder<List<SaccoModel>>(
                        stream: streamAllSaccosFromFirestore(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No Saccos found'),
                            );
                          }
                          if (snapshot.data!.isNotEmpty) {
                            var my_saccos = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: my_saccos.length,
                              itemBuilder: (context, index) {
                                SaccoModel sacco = my_saccos[index];
                                bool isSelected =
                                    _selectedSaccoIds.contains(sacco.saccoId);
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
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[900],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 16.0,
                        ),
                      ),
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
                        busStationCollection.doc(busStation.stationId).set(
                              busStation.toMap(),
                            );
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Save Bus Station',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // create a method to stream all saccos from firestore
  Stream<List<SaccoModel>> streamAllSaccosFromFirestore() {
    return saccoCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return SaccoModel.fromMap(doc.data());
      }).toList();
    });
  }

  List<SaccoModel> getAllSaccosFromFirestore() {
    List<SaccoModel> saccos = [];
    saccoCollection.get().then((value) {
      value.docs.forEach((element) {
        SaccoModel sacco = SaccoModel.fromMap(element.data());
        saccos.add(sacco);
      });
    });
    return saccos;
  }
}
