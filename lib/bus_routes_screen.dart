import 'package:bus_sacco/bus_route_details_screen.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class BusRoutesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Routes'),
      ),
      body: ListView.builder(
        itemCount: busRoutes.length,
        itemBuilder: (context, index) {
          final route = busRoutes[index];
          return ListTile(
            title: Text(route.source),
            subtitle: Text(route.destination),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BusRouteDetailsScreen(route: route)));
            },
          );
        },
      ),
    );
  }
}
