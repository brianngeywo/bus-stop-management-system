import 'package:bus_sacco/bus_registration_screen.dart';
import 'package:bus_sacco/bus_route_registration_screen.dart';
import 'package:bus_sacco/bus_routes_screen.dart';
import 'package:bus_sacco/bus_station_registration_screen.dart';
import 'package:bus_sacco/bus_stations_view_screen.dart';
import 'package:bus_sacco/buses_screen.dart';
import 'package:bus_sacco/dashboard_screen.dart';
import 'package:bus_sacco/driver_registration_screen.dart';
import 'package:bus_sacco/drivers_screen.dart';
import 'package:bus_sacco/sacco_registration_screen.dart';
import 'package:bus_sacco/saccos_screen.dart';
import 'package:flutter/material.dart';

class MySidebar extends StatefulWidget {
  const MySidebar({super.key});

  @override
  State<MySidebar> createState() => _MySidebarState();
}

class _MySidebarState extends State<MySidebar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.cyan[900],
        child: ListView(
          padding: const EdgeInsets.only(right: 16.0),
          children: [
            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return DashboardScreen();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.white),
              title: const Text(
                'Bus Stations',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BusStationsViewScreen();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.business, color: Colors.white),
              title:
                  const Text('Saccos', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SaccosScreen();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_bus, color: Colors.white),
              title: const Text('Buses', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BusesScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title:
                  const Text('Drivers', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DriversScreen();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.map, color: Colors.white),
              title: const Text('Bus Routes',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BusRoutesScreen()));
              },
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Registration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              // add appropriate icon according to the registration item
              leading: const Icon(Icons.map, color: Colors.white),
              title: const Text('Register Bus Route',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusRouteRegistrationScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.business, color: Colors.white),
              title: const Text('Register Sacco',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SaccoRegistrationScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Register Driver',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DriverRegistrationScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_bus, color: Colors.white),
              title: const Text('Register Bus',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusRegistrationScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.white),
              title: const Text('Register Bus Station',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusStationRegistrationScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
