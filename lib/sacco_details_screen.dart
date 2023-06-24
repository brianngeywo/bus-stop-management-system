import 'package:bus_sacco/bus_details_screen.dart';
import 'package:bus_sacco/bus_route_details_screen.dart';
import 'package:bus_sacco/driver_details_screen.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class SaccoDetailsScreen extends StatelessWidget {
  final SaccoModel sacco;

  SaccoDetailsScreen({required this.sacco});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sacco Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sacco Name:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              sacco.name,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Contact Information:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Phone: ${sacco.phoneNumber}',
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              'Email: ${sacco.emailAdress}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Days of operations:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sacco.activeDays.length,
              itemBuilder: (context, index) {
                var day = sacco.activeDays[index];
                return ListTile(
                  title: Text(day),
                );
              },
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Drivers:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getDriversBySaccoId(sacco.saccoId).length,
              itemBuilder: (context, index) {
                DriverModel driver = getDriversBySaccoId(sacco.saccoId)[index];
                return ListTile(
                  title: Text(driver.name),
                  subtitle: Text('Driver ID: ${driver.driverId}'),
                  onTap: () {
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
            const SizedBox(height: 24.0),
            const Text(
              'Buses:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getBusesBySaccoId(sacco.saccoId).length,
              itemBuilder: (context, index) {
                BusModel bus = getBusesBySaccoId(sacco.saccoId)[index];
                return ListTile(
                  title: Text('Bus Number: ${bus.numberPlate}'),
                  subtitle: Text('Route ID: ${bus.routeId}'),
                  onTap: () {
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
            const SizedBox(height: 24.0),
            const Text(
              'Routes:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getRoutesBySaccoId(sacco.saccoId).length,
              itemBuilder: (context, index) {
                BusRouteModel route = getRoutesBySaccoId(sacco.saccoId)[index];
                return ListTile(
                  title: Text('Source: ${route.source}'),
                  subtitle: Text('Destination: ${route.destination}'),
                  onTap: () {
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
          ],
        ),
      ),
    );
  }

  // Helper functions to retrieve related driver, bus, and route information for a Sacco
  List<DriverModel> getDriversBySaccoId(String saccoId) {
    // Replace this with your actual implementation
    List<DriverModel> relatedDrivers =
        drivers.where((driver) => driver.saccoId == saccoId).toList();
    return relatedDrivers;
  }

  List<BusModel> getBusesBySaccoId(String saccoId) {
    // Replace this with your actual implementation
    List<BusModel> relatedBuses =
        buses.where((bus) => bus.saccoId == saccoId).toList();
    return relatedBuses;
  }

  List<BusRouteModel> getRoutesBySaccoId(String saccoId) {
    //get list of buses by sacco id

    // Replace this with your actual implementation
    List<BusRouteModel> relatedRoutes = busRoutes
        .where((route) => getBusesBySaccoId(saccoId)
            .any((bus) => bus.routeId == route.routeId))
        .toList();
    return relatedRoutes;
  }
}
