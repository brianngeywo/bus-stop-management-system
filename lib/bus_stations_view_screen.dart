import 'package:bus_sacco/bus_station_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/dashboard_item_tile.dart';
import 'package:bus_sacco/models/bus_station.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';

import 'main_app_bar.dart';
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
      appBar: mainAppBar('TranspoLink Dashboard'),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<List<BusStationModel>>(
                stream: _fetchBusStationsFromFirestore(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        List<BusStationModel> busStations = snapshot.data!;

                        return DashboardTile(
                          title: busStations[index].name,
                          onPressed: () {
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
