import 'package:bus_sacco/bus_details_screen.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class DriverDetailsScreen extends StatelessWidget {
  final DriverModel driver;

  DriverDetailsScreen({required this.driver});

  @override
  Widget build(BuildContext context) {
    // Retrieve the bus and route information related to the driver
    List<BusModel> buses = getBusesByDriverId(driver.driverId);
    List<BusRouteModel> routes = getRoutesByDriverId(driver.driverId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Driver Name: ${driver.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Assigned Buses:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: buses.length,
              itemBuilder: (context, index) {
                final bus = buses[index];
                final route =
                    routes.firstWhere((route) => route.routeId == bus.routeId,
                        orElse: () => BusRouteModel(
                              routeId: 0,
                              source: 'N/A',
                              destination: 'N/A',
                              stops: [],
                              fareRate: 0.0,
                            ));

                return ListTile(
                  title: Text('Bus NumberPlate: ${bus.numberPlate}'),
                  subtitle:
                      Text('Route: ${route.source} - ${route.destination}'),
                  onTap: () {
                    // Navigate to the bus details screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BusDetailsScreen(bus: bus),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper functions to retrieve related bus and route information
  List<BusModel> getBusesByDriverId(int driverId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the related buses
    // based on the driverId
    List<BusModel> relatedBuses =
        buses.where((bus) => bus.driverId == driverId).toList();
    return relatedBuses;
  }

  List<BusRouteModel> getRoutesByDriverId(int driverId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the related routes
    // based on the driverId
    List<BusRouteModel> relatedRoutes = busRoutes
        .where((route) => getBusesByDriverId(driverId)
            .any((bus) => bus.routeId == route.routeId))
        .toList();
    return relatedRoutes;
  }
}
