import 'package:bus_sacco/models/bus_station.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sacco_details_screen.dart';
import 'package:flutter/material.dart';

class BusStationDetailsScreen extends StatelessWidget {
  final BusStationModel busStation;
  final List<SaccoModel> saccos;

  BusStationDetailsScreen({required this.busStation, required this.saccos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(busStation.name),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Location:'),
            subtitle: Text(busStation.location),
          ),
          ListTile(
            title: Text('ID:'),
            subtitle: Text(busStation.stationId.toString()),
          ),
          SizedBox(height: 20),
          Text('Saccos:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: saccos.length,
            itemBuilder: (context, index) {
              SaccoModel sacco = saccos[index];
              return ListTile(
                title: Text(sacco.name),
                subtitle: Text('Contact: ${sacco.contactInfo}'),
                trailing: Text('ID: ${sacco.saccoId}'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SaccoDetailsScreen(sacco: sacco)));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}