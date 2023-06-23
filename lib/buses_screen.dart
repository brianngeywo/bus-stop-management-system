import 'package:bus_sacco/bus_details_screen.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class BusesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buses'),
      ),
      body: ListView.builder(
        itemCount: buses.length,
        itemBuilder: (context, index) {
          final bus = buses[index];
          return ListTile(
            title: Text(bus.numberPlate),
            subtitle: Text(bus.routeId.toString()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BusDetailsScreen(bus: bus)));
            },
          );
        },
      ),
    );
  }
}
