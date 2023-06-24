import 'package:bus_sacco/bus_routes_screen.dart';
import 'package:bus_sacco/bus_stations_view_screen.dart';
import 'package:bus_sacco/buses_screen.dart';
import 'package:bus_sacco/dashboard_item_tile.dart';
import 'package:bus_sacco/drivers_screen.dart';
import 'package:bus_sacco/saccos_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('TranspoLink Dashboard'),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(right: 16.0),
              children: [
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Bus Stations'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_stations');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Saccos'),
                  onTap: () {
                    Navigator.pushNamed(context, '/saccos');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.directions_bus),
                  title: const Text('Buses'),
                  onTap: () {
                    Navigator.pushNamed(context, '/buses');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Drivers'),
                  onTap: () {
                    Navigator.pushNamed(context, '/drivers');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Bus Routes'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_routes');
                  },
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Registration',
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Register Bus Station'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_station_registration');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Register Sacco'),
                  onTap: () {
                    Navigator.pushNamed(context, '/sacco_registration');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.directions_bus),
                  title: const Text('Register Bus'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_registration');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Register Driver'),
                  onTap: () {
                    Navigator.pushNamed(context, '/driver_registration');
                  },
                ),
                ListTile(
                  // add appropriate icon according to the registration item
                  leading: const Icon(Icons.map),
                  title: const Text('Register Bus Route'),
                  onTap: () {
                    Navigator.pushNamed(context, '/bus_route_registration');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                DashboardTile(
                  title: "Bus Stations",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BusStationsViewScreen(),
                      ),
                    );
                  },
                ),
                DashboardTile(
                  title: 'Saccos',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SaccosScreen()),
                    );
                  },
                ),
                DashboardTile(
                  title: 'Drivers',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DriversScreen()),
                    );
                  },
                ),
                DashboardTile(
                  title: 'Buses',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BusesScreen()),
                    );
                  },
                ),
                DashboardTile(
                  title: 'Bus Routes',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusRoutesScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
