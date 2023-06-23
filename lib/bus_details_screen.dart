import 'package:bus_sacco/bus_route_details_screen.dart';
import 'package:bus_sacco/driver_details_screen.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sacco_details_screen.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class BusDetailsScreen extends StatelessWidget {
  final BusModel bus;

  BusDetailsScreen({required this.bus});

  @override
  Widget build(BuildContext context) {
    // Retrieve the related entities
    final DriverModel driver = getDriverById(bus.driverId);
    final BusRouteModel route = getRouteById(bus.routeId);
    final SaccoModel sacco = getSaccoById(bus.saccoId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Bus ID: ${bus.busId}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Number Plate: ${bus.numberPlate}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                // Navigate to BusRouteDetailsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusRouteDetailsScreen(route: route),
                  ),
                );
              },
              child: Text(
                'Route: ${route.source} - ${route.destination}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                // Navigate to SaccoDetailsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaccoDetailsScreen(sacco: sacco),
                  ),
                );
              },
              child: Text(
                'Sacco: ${sacco.name}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                // Navigate to DriverDetailsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriverDetailsScreen(driver: driver),
                  ),
                );
              },
              child: Text(
                'Driver: ${driver.name}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Has Left Source: ${bus.hasLeftSource}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Has Arrived at Destination: ${bus.hasArrivedDestination}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Helper functions to retrieve related entities
  DriverModel getDriverById(int driverId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the driver
    // based on the driverId
    return drivers.firstWhere((driver) => driver.driverId == driverId);
  }

  BusRouteModel getRouteById(int routeId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the route
    // based on the routeId
    return busRoutes.firstWhere((route) => route.routeId == routeId);
  }

  SaccoModel getSaccoById(int saccoId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the sacco
    // based on the saccoId
    return saccos.firstWhere((sacco) => sacco.saccoId == saccoId);
  }
}
