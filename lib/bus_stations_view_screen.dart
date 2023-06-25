import 'package:bus_sacco/bus_station_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/bus_station.dart';
import 'package:flutter/material.dart';

import 'models/sacco_model.dart';

class BusStationsViewScreen extends StatefulWidget {
  BusStationsViewScreen({Key? key}) : super(key: key);

  @override
  State<BusStationsViewScreen> createState() => _BusStationsViewScreenState();
}

class _BusStationsViewScreenState extends State<BusStationsViewScreen> {
  Stream<List<BusStationModel>> _fetchBusStationsFromFirestore() {
    return busStationCollection.snapshots().map((snapshot) {
      List<BusStationModel> busStations = [];
      snapshot.docs.forEach((document) {
        busStations.add(BusStationModel.fromMap(document.data()));
      });
      return busStations;
    });
  }

  List<BusStationModel> busStations = [];
  List<SaccoModel> saccos = [];

  void _fetchBusStations() {
    busStationCollection.get().then((querySnapshot) {
      List<BusStationModel> fetchedBusStations = [];
      querySnapshot.docs.forEach((document) {
        fetchedBusStations.add(BusStationModel.fromMap(document.data()));
      });
      setState(() {
        busStations = fetchedBusStations;
      });
    });
  }

  @override
  void initState() {
    _fetchBusStations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('TranspoLink Dashboard'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(right: 16.0),
              children: [
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Bus Stations'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_stations');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Saccos'),
                  onTap: () {
                    Navigator.pushNamed(context, '/saccos');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.directions_bus),
                  title: const Text('Buses'),
                  onTap: () {
                    Navigator.pushNamed(context, '/buses');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Drivers'),
                  onTap: () {
                    Navigator.pushNamed(context, '/drivers');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Bus Routes'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_routes');
                  },
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Registration',
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Register Bus Station'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_station_registration');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Register Sacco'),
                  onTap: () {
                    Navigator.pushNamed(context, '/sacco_registration');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.directions_bus),
                  title: const Text('Register Bus'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_registration');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Register Driver'),
                  onTap: () {
                    Navigator.pushNamed(context, '/driver_registration');
                  },
                ),
                ListTile(
                  // add appropriate icon according to the registration item
                  leading: const Icon(Icons.map),
                  title: const Text('Register Bus Route'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_route_registration');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: StreamBuilder<List<BusStationModel>>(
              stream: _fetchBusStationsFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List<BusStationModel> busStations = snapshot.data!;

                      return ListTile(
                        title: Text(
                          busStations[index].name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Location: ${busStations[index].location}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusStationDetailsScreen(
                                busStation: busStations[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
