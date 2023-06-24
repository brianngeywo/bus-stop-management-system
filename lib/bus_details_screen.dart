import 'package:bus_sacco/bus_route_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/driver_details_screen.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sacco_details_screen.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class BusDetailsScreen extends StatefulWidget {
  final BusModel bus;

  BusDetailsScreen({super.key, required this.bus});

  @override
  State<BusDetailsScreen> createState() => _BusDetailsScreenState();
}

class _BusDetailsScreenState extends State<BusDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Retrieve the related entities
    final DriverModel driver = getDriverById(widget.bus.driverId);
    final BusRouteModel route = getRouteById(widget.bus.routeId);
    final SaccoModel? sacco = getSaccoById(widget.bus.saccoId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Bus ID: ${widget.bus.busId}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Number Plate: ${widget.bus.numberPlate}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
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
                'Sacco: ${sacco!.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Has Left Source: ${widget.bus.hasLeftSource}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Has Arrived at Destination: ${widget.bus.hasArrivedDestination}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Helper functions to retrieve related entities
  DriverModel getDriverById(String driverId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the driver
    // based on the driverId
    return drivers.firstWhere((driver) => driver.driverId == driverId);
  }

  BusRouteModel getRouteById(String routeId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the route
    // based on the routeId
    return busRoutes.firstWhere((route) => route.routeId == routeId);
  }

  SaccoModel? getSaccoById(String saccoId) {
    SaccoModel? saccoModel;
    saccoCollection.doc(saccoId).get().then((value) {
      setState(() {
        saccoModel = SaccoModel.fromMap(value.data()!);
      });
      return saccoModel;
    });
    return saccoModel;
  }
}
