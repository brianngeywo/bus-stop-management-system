import 'package:bus_sacco/bus_station_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/bus_station.dart';
import 'package:flutter/material.dart';

import 'models/sacco_model.dart';

class BusStationsViewScreen extends StatefulWidget {
  BusStationsViewScreen({super.key});

  @override
  State<BusStationsViewScreen> createState() => _BusStationsViewScreenState();
}

class _BusStationsViewScreenState extends State<BusStationsViewScreen> {
  //fetch saccos related to the bus station from firestore

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

// Fetch the bus stations list from Firestore
  void _fetchBusStations() {
    busStationCollection.get().then((querySnapshot) {
      List<BusStationModel> fetchedBusStations = [];
      querySnapshot.docs.forEach((document) {
        fetchedBusStations.add(BusStationModel.fromMap(document.data()));
      });
      setState(() {
        busStations = fetchedBusStations;
      });
      return busStations;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchBusStations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Stations'),
      ),
      body: StreamBuilder<List<BusStationModel>>(
          stream: _fetchBusStationsFromFirestore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isNotEmpty) {
              return Center(
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List<BusStationModel> busStations = snapshot.data!;

                      return ListTile(
                        title: Text(busStations[index].name),
                        subtitle:
                            Text('Location: ${busStations[index].location}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusStationDetailsScreen(
                                busStation: busStations[index],
                                saccos: saccos,
                              ),
                            ),
                          );
                        },
                      );
                    }),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
