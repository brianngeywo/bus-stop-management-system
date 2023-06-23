import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class BusRouteDetailsScreen extends StatelessWidget {
  final BusRouteModel route;

  BusRouteDetailsScreen({required this.route});

  @override
  Widget build(BuildContext context) {
    // Retrieve the related buses and driver information
    List<BusModel> buses = getBusesByRouteId(route.routeId);
    List<DriverModel> drivers = getDriversByRouteId(route.routeId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Route Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Route ID: ${route.routeId}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Source: ${route.source}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Destination: ${route.destination}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Stops: ${route.stops.join(', ')}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Fare Rate: ${route.fareRate}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Buses:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: buses.length,
              itemBuilder: (context, index) {
                final bus = buses[index];
                final driver = drivers.firstWhere(
                  (driver) => driver.driverId == bus.driverId,
                  orElse: () => DriverModel(
                    driverId: 0,
                    name: 'N/A',
                    contactInfo: 'N/A',
                    saccoId: 0,
                  ),
                );

                return ListTile(
                  title: Text('Bus Details:'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bus ID: ${bus.busId}'),
                      Text('Number Plate: ${bus.numberPlate}'),
                      Text('Driver: ${driver.name}'),
                      // Display other bus information as desired
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper functions to retrieve related buses and drivers
  List<BusModel> getBusesByRouteId(int routeId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the related buses
    // based on the routeId
    return buses.where((bus) => bus.routeId == routeId).toList();
  }

  List<DriverModel> getDriversByRouteId(int routeId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the related drivers
    // based on the routeId
    return drivers
        .where((driver) => getBusesByRouteId(routeId)
            .any((bus) => bus.driverId == driver.driverId))
        .toList();
  }
}
