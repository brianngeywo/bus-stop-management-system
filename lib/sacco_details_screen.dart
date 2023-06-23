import 'package:bus_sacco/bus_details_screen.dart';
import 'package:bus_sacco/bus_route_details_screen.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

import 'driver_details_screen.dart';

class SaccoDetailsScreen extends StatelessWidget {
  final SaccoModel sacco;

  SaccoDetailsScreen({required this.sacco});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sacco Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Sacco Name: ${sacco.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Contact Information: ${sacco.contactInfo}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Drivers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getDriversBySaccoId(sacco.saccoId).length,
              itemBuilder: (context, index) {
                DriverModel driver = getDriversBySaccoId(sacco.saccoId)[index];
                return ListTile(
                  title: Text(driver.name),
                  subtitle: Text('Driver ID: ${driver.driverId}'),
                  onTap: () {
                    // Navigate to driver details screen passing the driver object
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DriverDetailsScreen(driver: driver),
                      ),
                    );
                  },
                );
              },
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
              itemCount: getBusesBySaccoId(sacco.saccoId).length,
              itemBuilder: (context, index) {
                BusModel bus = getBusesBySaccoId(sacco.saccoId)[index];
                return ListTile(
                  title: Text('Bus Number: ${bus.numberPlate}'),
                  subtitle: Text('Route ID: ${bus.routeId}'),
                  onTap: () {
                    // Navigate to bus details screen passing the bus object
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusDetailsScreen(bus: bus)),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Routes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getRoutesBySaccoId(sacco.saccoId).length,
              itemBuilder: (context, index) {
                BusRouteModel route = getRoutesBySaccoId(sacco.saccoId)[index];
                return ListTile(
                  title: Text('Source: ${route.source}'),
                  subtitle: Text('Destination: ${route.destination}'),
                  onTap: () {
                    // Navigate to route details screen passing the route object
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BusRouteDetailsScreen(route: route),
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

  // Helper functions to retrieve related driver, bus, and route information for a Sacoo
  List<DriverModel> getDriversBySaccoId(int saccoId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the related drivers
    // based on the saccoId
    List<DriverModel> relatedDrivers =
        drivers.where((driver) => driver.saccoId == saccoId).toList();
    return relatedDrivers;
  }

  List<BusModel> getBusesBySaccoId(int saccoId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the related buses
    // based on the saccoId
    List<BusModel> relatedBuses =
        buses.where((bus) => bus.saccoId == saccoId).toList();
    return relatedBuses;
  }

  List<BusRouteModel> getRoutesBySaccoId(int saccoId) {
    // Replace this with your actual implementation
    // Query the database or use any other logic to fetch the related routes
    // based on the saccoId
    List<BusRouteModel> relatedRoutes = busRoutes
        .where((route) => getBusesBySaccoId(saccoId)
            .any((bus) => bus.routeId == route.routeId))
        .toList();
    return relatedRoutes;
  }
}
