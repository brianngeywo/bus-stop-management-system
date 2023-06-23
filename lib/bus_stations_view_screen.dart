import 'package:bus_sacco/bus_station_details_screen.dart';
import 'package:bus_sacco/models/bus_station.dart';
import 'package:flutter/material.dart';

import 'models/sacco_model.dart';

class BusStationsViewScreen extends StatelessWidget {
  final List<BusStationModel> busStations;
  final List<SaccoModel> saccos; // Add this property

  BusStationsViewScreen({required this.busStations, required this.saccos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Stations'),
      ),
      body: ListView.builder(
        itemCount: busStations.length,
        itemBuilder: (context, index) {
          BusStationModel busStation = busStations[index];
          List<SaccoModel> saccosUnderStation = saccos
              .where((sacco) => busStation.saccoIds.contains(sacco.saccoId))
              .toList(); // Filter saccos under the current bus station
          return ListTile(
            title: Text(busStation.name),
            subtitle: Text('Location: ${busStation.location}'),
            trailing: Text('ID: ${busStation.stationId}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusStationDetailsScreen(
                      busStation: busStation, saccos: saccosUnderStation),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
